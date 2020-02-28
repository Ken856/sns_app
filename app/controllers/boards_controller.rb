class BoardsController < ApplicationController
  before_action :logged_in_user

  def index
    @boards = Board.page(params[:page]).per(10)
    @searches = Board.search(params[:search], "title")
  end

  def show
    @board = Board.includes(:user).find(params[:id])
    @posts = @board.posts.includes(:user).all
    @post = @board.posts.build
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:notice] = "スレを作りました"
      redirect_to @board
    else
      render :new
    end
  end

  private
    def board_params
      params.require(:board).permit(:title)
    end
end
