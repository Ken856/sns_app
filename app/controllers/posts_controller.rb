class PostsController < ApplicationController

  def create
    @board = Board.find(params[:board_id])
    @post = @board.posts.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "コメントしました。"
      redirect_to @board
    else
      flash[:dager] = "コメントに失敗しました。"
      redirect_to @board
    end
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end
end
