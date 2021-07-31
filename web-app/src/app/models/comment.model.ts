import {ImageModel} from './image.model';
import {User} from './user.model';

export class CommentModel{
  constructor(public id: number, public text: string, public  image: ImageModel, public date: Date, public user: User, public comments: CommentModel[]) {
  }
}
