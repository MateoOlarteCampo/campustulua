class ArchivesController < ApplicationController
  before_action :set_archive, only: [:update, :destroy]
  before_action :set_course
  before_action :autenticathe_login!
  before_action :autenticathe_date!, except: [:download]
  
  # POST /courses/1/archives
  # POST /courses/1/archives.json
  def create
    @archive = @course.archives.new(archive_params)
    @archive.course = @course
    respond_to do |format|
      if @archive.save
        format.html { redirect_to @archive.course}
        format.json { render :show, status: :created, location: @archive }
      else
        format.html { render :new }
        format.json { render json: @archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1/archives/1
  # PATCH/PUT /courses/1/archives/1.json
  def update
    respond_to do |format|
      if @archive.update(archive_params)
        format.html { redirect_to @archive.course}
        format.json { render :show, status: :ok, location: @archive }
      else
        format.html { render :edit }
        format.json { render json: @archive.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1/archives/1
  # DELETE /courses/1/archives/1.json
  def destroy
    @archive.destroy
    respond_to do |format|
      format.html { redirect_to @archive.course}
      format.json { head :no_content }
    end
  end

  def download
    @archive = Archive.find(params[:id])
    send_file @archive.file.path, :disposition => 'attachment'
  end

  private

     # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:course_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_archive
      @archive = Archive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def archive_params
      params.require(:archive).permit(:name, :description, :file, :course_id)
    end
end
