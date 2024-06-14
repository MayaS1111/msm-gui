class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  
  def create
    d = Director.new
    d.title = params.fetch("the_title")
    d.year = params.fetch("the_year")
    d.duration = params.fetch("the_duration")
    d.description = params.fetch("the_description")
    d.image = parads.fetch("the_image")
    d.director_id = params.fetch("the_director_id")

    d.save

    redirect_to("/directors")

  end

  def destroy
    
    the_id = params.fetch("an_id")
    director = Director.where({:id => the_id}).at(0)

    director.destroy

    redirect_to("/directors")

  end

  def update
    the_id = params.fetch("an_id")
    d = Director.where({:id => the_id}).at(0)

    d.title = params.fetch("query_title")
    d.year = params.fetch("query_year")
    d.duration = params.fetch("query_duration")
    d.description = params.fetch("query_description")
    d.image = params.fetch("query_image")
    d.director_id = params.fetch("query_director_id")

    d.save

    redirect_to("/directors/#{the_id}")
  end
end
