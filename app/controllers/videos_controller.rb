class VideosController < ApplicationController
  before_action :set_course
  before_action :set_video, only: [:update, :destroy, :show]

  # Listar vídeos de um curso
  def index
    @videos = @course.videos
    render json: @videos
  end

  # Criar um novo vídeo para um curso
  def create
    @video = @course.videos.build(video_params)
    if @video.save
      render json: @video, status: :created
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # Atualizar um vídeo existente
  def update
    if @video.update(video_params)
      render json: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # Deletar um vídeo
  def destroy
    @video.destroy
    head :no_content
  end

  def show
    if @video.file.attached?
      video_url = url_for(@video.file)
      render json: {
        id: @video.id,
        title: @video.title,
        url: video_url,
        size: @video.file.byte_size,
        content_type: @video.file.content_type
      }, status: :ok
    else
      render json: { error: "Video file not found" }, status: :not_found
    end
  end

  private

  # Encontrar o curso com base no course_id
  def set_course
    @course = Course.find(params[:course_id])
  end

  # Encontrar o vídeo com base no id
  def set_video
    @video = @course.videos.find(params[:id])
  end

  # Parâmetros permitidos para vídeo
  def video_params
    params.permit(:title, :file, :course_id)
  end
end
