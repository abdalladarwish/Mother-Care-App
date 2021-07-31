import {ImageModel} from './image.model';
import {User} from './user.model';

export class PostModel{
  constructor(public postId:number, public text: string, public image: ImageModel, public date: Date, public user: User) {}
}
