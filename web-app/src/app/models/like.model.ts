import {ImageModel} from './image.model';
import {User} from './user.model';
import {BlogModel} from './blog.model';

export class LikeModel {
  constructor(public id: number, public blog: BlogModel , public user: User){
  }
}
