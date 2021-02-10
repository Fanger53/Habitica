class HabitsController < ApplicationController
  include HabitsHelper
  include GroupsHelper

  def index
    @habits = Habit.all.includes(:repeat_days) 
  end

  def new
    @habit = current_user.habits.new
    @habit.groups.build
    @groups = Group.all
  end

  def create
    
    @habit = current_user.habits.new(habit_params.select{|key, value| key != 'group_id'})
    if @habit.save
        GroupHabit.create(habit_id: @habit.id, group_id: habit_params[:group_id])
      redirect_to habit_path({id: @habit.id}), notice: 'Habit successfully created.'
    else
      flash.now[:alert] = @habit.errors.full_messages.first
      render :new
    end 
  end

  def show
    @habit = Habit.find(params[:id])
  end

  def external_habits
    a = Group.where(name: '')
    group = a[0]
    @habits=group.habits
  end
end
    