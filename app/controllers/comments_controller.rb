class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
    else
      @prototype = @comment.prototype    #@comment(コメント)に紐づくprototype(投稿)を左辺に代入
      @comments = @prototype.comments    #@prototype(投稿)に紐づくcomments(コメントたち)を左辺に代入
      render "prototypes/show" # views/tweets/show.html.erbのファイルを参照しています。
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end