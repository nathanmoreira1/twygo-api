class CoursesController < ApplicationController
  # Listar todos os cursos ativos
  def index
    @q = Course.ransack(params[:q])
    @courses = @q.result.where('end_date >= ?', Date.current).paginate(page: params[:page], per_page: params[:per_page] || 10)

    render json: {
      courses: @courses,
      total_pages: @courses.total_pages,
      current_page: @courses.current_page,
    }
  end

  # Mostrar um curso
  def show
    @course = Course.find(params[:id])
    render json: @course
  end

  # Criar novo curso
  def create
    @course = Course.new(course_params)
    if @course.save
      render json: @course, status: :created
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # Atualizar curso
  def update
    @course = Course.find(params[:id])
    if @course.update(course_params)
      render json: @course
    else
      render json: @course.errors, status: :unprocessable_entity
    end
  end

  # Deletar curso
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    head :no_content
  end

  private

  def course_params
    params.require(:course).permit(:title, :description, :start_date, :end_date)
  end
end
