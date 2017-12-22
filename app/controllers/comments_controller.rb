class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :set_article
  before_action :autenticathe_login!

 
  # POST /articles/1/comments
  # POST /articles/:article_id/comments.json
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.article = @article
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.article}
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1/comments/1
  # PATCH/PUT /articles/1/comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.article}
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1/comments/1
  # DELETE /articles/1/comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article}
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:article_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :article_id, :body)
    end
end
