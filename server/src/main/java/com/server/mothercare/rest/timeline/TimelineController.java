package com.server.mothercare.rest.timeline;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.server.mothercare.entities.User;
import com.server.mothercare.entities.post.Blog;
import com.server.mothercare.entities.post.Comment;
import com.server.mothercare.entities.post.Like;
import com.server.mothercare.entities.post.SavedBlog;
import com.server.mothercare.services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.SerializationUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.security.Principal;
import java.sql.Timestamp;
import java.util.*;
import java.util.zip.DataFormatException;
import java.util.zip.Deflater;
import java.util.zip.Inflater;

@RestController
public class TimelineController {

    private CommentService commentService;

    private BlogService blogService;

    private UserService userService;

    private SseService sseService;

    private LikeService likeService;

    private SavedBlogService savedBlogService;

    @Autowired
    public TimelineController(CommentService commentService, BlogService blogService, UserService userService,
                              SseService sseService, LikeService likeService, SavedBlogService savedBlogService){
        this.commentService = commentService;
        this.blogService = blogService;
        this.userService = userService;
        this.sseService = sseService;
        this.likeService = likeService;
        this.savedBlogService = savedBlogService;
    }

    @PostMapping(value = "/blog/save")
    private ResponseEntity saveBlog(@RequestBody Blog theBlog,
                                    Principal userPrincipal)
    {
        User user= userService.userbyUserName(userPrincipal.getName());
        theBlog.setUser(user);
        theBlog.setDate(new Timestamp(new Date().getTime()));
        Blog savedBlog = blogService.save(theBlog);
        sseService.process(theBlog, "Blog", "insert");
        return savedBlog != null? new ResponseEntity(savedBlog, HttpStatus.OK) : new ResponseEntity(savedBlog, HttpStatus.CONFLICT);
    }

    @PostMapping(value = "/blog/update")
    private ResponseEntity getBlogUpdates(@RequestBody Blog theBlog,  Principal userPrincipal) {

        User user= userService.userbyUserName(userPrincipal.getName());
        Blog DBBlog = blogService.getBlogById(theBlog.getId());

        if (DBBlog.equals(null)){
            return new ResponseEntity("\"FAILURE\"", HttpStatus.NOT_FOUND) ;
        }

        if (!user.getUsername().equals(DBBlog.getUser().getUsername())) {

            return new ResponseEntity(theBlog, HttpStatus.UNAUTHORIZED) ;
        }
        blogService.update(theBlog);
        sseService.process(theBlog, "Blog", "update");
        return new ResponseEntity(theBlog, HttpStatus.OK) ;
    }

    @PostMapping(value = "/blog/delete/{id}")
    private ResponseEntity seleteBlog(@PathVariable int id,  Principal userPrincipal) {

        User user= userService.userbyUserName(userPrincipal.getName());
        Blog DBBlog = blogService.getBlogById(id);

        if (DBBlog.equals(null)){
            return new ResponseEntity("\"FAILURE\"", HttpStatus.NOT_FOUND) ;
        }

        if (!user.getUsername().equals(DBBlog.getUser().getUsername())) {
            return new ResponseEntity("\"FAILURE\"", HttpStatus.UNAUTHORIZED) ;
        }
        sseService.process(DBBlog, "Blod", "delete");
        blogService.deleteById(id);
        return new ResponseEntity("\"SUCCESS\"", HttpStatus.OK) ;
    }

    @PostMapping(value = "/blog/bommark/{blogId}")
    private ResponseEntity bommarkBlog(@PathVariable int blogId,  Principal userPrincipal){
        User theUser = userService.userbyUserName(userPrincipal.getName());
        Blog theBlog = blogService.getBlogById(blogId);
        if (theUser.equals(null) || theBlog.equals(null)){
            return  new ResponseEntity("\"Failure\"", HttpStatus.BAD_REQUEST);
        }else {
            SavedBlog theSavedBlog = new SavedBlog();
            theSavedBlog.setBlog(theBlog);
            theSavedBlog.setUser(theUser);
            boolean saved = savedBlogService.bommarkBlog(theSavedBlog);
            return  saved  ? new ResponseEntity(theUser, HttpStatus.OK) : new ResponseEntity("\"Failure\"", HttpStatus.BAD_REQUEST);
        }
    }
    @GetMapping(value = "/blog/bommark")
    private ResponseEntity bommarkBlog(  Principal userPrincipal){
            List<Blog> blogs = null;
            blogs = savedBlogService.userBommarks(userPrincipal.getName());

            return  blogs.equals(null)  ?  new ResponseEntity("\"Failure\"", HttpStatus.NO_CONTENT) : new ResponseEntity(blogs, HttpStatus.OK) ;
    }

    @GetMapping(value = "/blog/my_blogs")
    private ResponseEntity getUserBlogs(  Principal userPrincipal){
            List<Blog> blogs = null;
            blogs = blogService.getUserBlogs(userPrincipal.getName());

            return  new ResponseEntity(blogs, HttpStatus.OK) ;
    }

    @GetMapping(value = "/blog/get/{user}/{category}/{lastId}")
    private ResponseEntity getBlogs(@PathVariable int lastId, @PathVariable String user, @PathVariable String category){
        List<Blog> blogs = null;
        blogs = blogService.getBlogs(lastId, user, category);
        ResponseEntity response = blogs == null? new ResponseEntity("Failure", HttpStatus.NO_CONTENT): new ResponseEntity(blogs, HttpStatus.OK);
        ObjectMapper mapper = new ObjectMapper();
        try {
            String json = mapper.writeValueAsString(blogs);
            System.out.println(json);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        return response;
    }
    @GetMapping(value = "/blog/count/{author}/{category}")
    private ResponseEntity getBlogs(@PathVariable String author, @PathVariable String category){
        long count = blogService.blogsCount(author, category);
        return new ResponseEntity(count, HttpStatus.OK);
    }

    @PostMapping(value = "/comment/{theId}")
    private ResponseEntity saveComment(@PathVariable int theId,
                                       @RequestBody Comment theComment,
                                       Principal userPrincipal){

        Blog DbBlog = blogService.getBlogById(theId);
        User user= userService.userbyUserName(userPrincipal.getName());
        if (DbBlog == null){
            return new ResponseEntity("\"Failure\"", HttpStatus.NO_CONTENT);
        }else {
            theComment.setDate(new Timestamp(new Date().getTime()));
            theComment.setUser(user);
            theComment.setBlogId(theId);
            DbBlog.addComment(theComment);
            Blog blog = blogService.update(DbBlog);
            sseService.process(blog, "Comment", "insert");
            return  blog == null ? new ResponseEntity("\"Failure\"", HttpStatus.NO_CONTENT): new ResponseEntity(blog, HttpStatus.OK);
        }
    }

    @PostMapping(value = "/commentToComment/{commentId}")
    private ResponseEntity saveCommentToComment(@PathVariable int commentId,
                                                @RequestBody Comment theComment,
                                                Principal userPrincipal){

        User user= userService.userbyUserName(userPrincipal.getName());
        Comment commentDB = commentService.getCommentById(commentId);
        theComment.setDate(new Timestamp(new Date().getTime()));
        theComment.setUser(user);


        commentDB.addComment(theComment);

        Comment comment = commentService.update(commentDB);
        Blog blog = blogService.getBlogById(commentDB.getBlogId());
        sseService.process(blog, "Comment", "insert");
        return  comment == null ? new ResponseEntity("\"Failure\"", HttpStatus.NO_CONTENT): new ResponseEntity(comment, HttpStatus.OK);
    }


    @PostMapping(value = "/like/{blogId}")
    public ResponseEntity addLike(@PathVariable int blogId, Principal userPrincipal){
        User user= userService.userbyUserName(userPrincipal.getName());
        Like theLike = new Like();
        theLike.setUser(user);
        Blog DbBlog = blogService.getBlogById(blogId);
        DbBlog.addLikes(theLike);
        Like like = likeService.save(theLike);
        sseService.process(DbBlog, "Like", "insert");
        return like== null? new ResponseEntity("\"Failure\"", HttpStatus.CONFLICT) : new ResponseEntity(like, HttpStatus.OK);
    }

    @PostMapping(value = "/like/delete/{likeId}")
    public ResponseEntity deleteLike(@PathVariable int likeId, Principal userPrincipal){
        User user= userService.userbyUserName(userPrincipal.getName());
        Like theLike = null;
        boolean deleted = false;
        System.out.println("----------------------delete blog"+likeId);
        Optional<Like> like = likeService.getLikeById(likeId);
        if(like.isPresent()){
            theLike = like.get();
        }
        if (theLike.equals(null)){

        }else {
            deleted = likeService.deleteLike(theLike.getId());
            sseService.process(theLike.getBlog(), "Like", "insert");
        }

        return (deleted == false)?
                new ResponseEntity("\"Failure\"", HttpStatus.CONFLICT) :
                new ResponseEntity("\"Like Deleted Successsufly\"", HttpStatus.OK);
    }
    @GetMapping("/blog/liked")
    public ResponseEntity likedPosts(Principal userPrincipal){
        List<Blog> likedBlogs = blogService.getLikedBlogs(userPrincipal.getName());
        return likedBlogs != null? new ResponseEntity(likedBlogs, HttpStatus.OK):new ResponseEntity("\"Failure\"", HttpStatus.CONFLICT);
    }
    @GetMapping("/blog/updates")
    public @ResponseBody
    SseEmitter getEmitter() {
        System.out.println("in updates");
        return sseService.registerClient();
    }


    public static byte[] compressBytes(byte[] data) {
        Deflater deflater = new Deflater();
        deflater.setInput(data);
        deflater.finish();
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
        byte[] buffer = new byte[1024];
        while (!deflater.finished()) {
            int count = deflater.deflate(buffer);
            outputStream.write(buffer, 0, count);
        }
        try {
            outputStream.close();
        } catch (IOException e) {
        }
        System.out.println("Compressed Image Byte Size - " + outputStream.toByteArray().length);
        return outputStream.toByteArray();
    }
    // uncompress the image bytes before returning it to the angular application
    public static byte[] decompressBytes(byte[] data) {
        Inflater inflater = new Inflater();
        inflater.setInput(data);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream(data.length);
        byte[] buffer = new byte[1024];
        try {
            while (!inflater.finished()) {
                int count = inflater.inflate(buffer);
                outputStream.write(buffer, 0, count);
            }
            outputStream.close();
        } catch (IOException ioe) {
        } catch (DataFormatException e) {
        }
        return outputStream.toByteArray();
    }
}
