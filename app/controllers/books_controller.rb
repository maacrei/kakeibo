class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  # ストロングパラメータに「set_book」というメソッドを作り、上記を記述することで
  # show,edit,update,destroyアクションに「@book = Book.find(params[:id]」という記述がいらなくなる
  # before_actionは基本的に全てのコントローラ内のアクションの前に実行するので、onlyというオプションで実行するアクションを制限している

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "家計簿にデータを１件登録しました。"
      redirect_to books_path
    else
      flash.now[:alert] = "登録に失敗しました。"
      render :new
    end
  end

  def index
    @books = Book.all
    @books = @books.where(year: params[:year]) if params[:year].present?
    @books = @books.where(month: params[:month]) if params[:month].present?
    # 上記２つは検索のための記述
  end

  def show
    # @book = Book.find(params[:id])　←ストロングパラメータにメソッドを作ったことにより記述が不要になった
  end

  def edit
    # @book = Book.find(params[:id])
  end

  def update
    # @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "データを１件更新しました。"
      redirect_to book_path(@book)
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    # @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "削除しました。"
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:year, :month, :inout, :category, :amount)
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
