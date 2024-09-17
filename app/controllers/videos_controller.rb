class VideosController < ApplicationController
  before_action :set_course
  before_action :set_video, only: [:update, :destroy, :show, :stream]

  # Listar vídeos de um curso
  def index
    @videos = @course.videos
    render json: @videos
  end

  def index
    @videos = @course.videos.paginate(page: params[:page], per_page: params[:per_page] || 10)

    render json: {
      videos: @videos,
      total_pages: @videos.total_pages,
      current_page: @videos.current_page,
      per_page: params[:per_page] || 10
    }
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
    render json: {
      id: @video.id,
      title: @video.title,
      file_name: @video.file.filename.to_s,
      created_at: @video.created_at,
      updated_at: @video.updated_at
    }
  end

  def stream
    response.headers["Content-Type"] = @video.file.content_type
    response.headers["Content-Disposition"] = "inline; filename=\"#{@video.file.filename}\""

    @video.file.download do |chunk|
      response.stream.write(chunk)
    end
  ensure
    response.stream.close
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
    params.permit(:id, :title, :file, :course_id)
  end
end
