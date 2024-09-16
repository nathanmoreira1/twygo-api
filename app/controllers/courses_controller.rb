class CoursesController < ApplicationController
  # Listar todos os cursos ativos
  def index
    @courses = Course.where('end_date >= ?', Date.today)
    render json: @courses
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
