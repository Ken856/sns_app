class PostsController < ApplicationController

  def create
    @board = Board.find(params[:board_id])
    @post = @board.posts.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "成功"
      redirect_to @board
    else
      render "boards/show"
    end
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end
end
