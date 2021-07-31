import {ImageModel} from './image.model';
import {User} from './user.model';
import {CommentModel} from './comment.model';
import {LikeModel} from './like.model';

export class BlogModel{
  constructor(public id: number,
              public admin: boolean,
              public html: string,
              public title: string,
              public description: string,
              public categories: string,
              public image: ImageModel,
              public comments: CommentModel[],
              public date: Date,
              public user: User,
              public likes: LikeModel[]
  ) {}
}
