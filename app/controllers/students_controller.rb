class StudentsController < ApplicationController
  before_action :login_check

  def get_gakunen(id:)
    record =Grade.find_by(id: id)
    return record.gakunen
  end
  
  def index
    @students =Student.all.order(created_at: :asc)
  end

  def search
    @students =Student.where(num: params[:num]).or(Student.where(family_name: params[:family_name]).or(Student.where(first_name: params[:first_name])))
    render "students/index"
  end

  def new
    @student =Student.new
  end

  def create
    @student =Student.new(
      num: params[:num],
      family_name: params[:family_name],
      first_name: params[:first_name]
    )
    if @student.save
      flash[:notice] ="新規生徒を追加しました"
      redirect_to "/students/#{@student.id}"
    end
  end

  def show
    @student =Student.find_by(id: params[:id])
    @year =Time.new.year
  end

  def edit
    @student =Student.find_by(id: params[:id])
  end
  
  def update
    @student =Student.find_by(id: params[:id])
    @student.num =params[:num]
    @student.family_name =params[:family_name]
    @student.first_name =params[:first_name]
    if @student.save
      flash[:notice] ="生徒情報を更新しました"
      redirect_to "/students/#{@student.id}"
    end
  end
  
  def destroy
    @student =Student.find_by(id: params[:id])
    @student.destroy
    flash[:notice] ="生徒情報を削除しました"
    redirect_to "/students/index"
  end

  def test
    @student =Student.find_by(id: params[:id])
    @year =params[:year].to_i
    @grade =get_gakunen(id: @student["grade_id_#{@year.to_s}"])
    #@student =Student.find_by(id: 5) #テスト用
    #@year ="2022".to_i #テスト用
    puts "#{@student.num}, #{@student.family_name} #{@student.first_name}_#{@year}"
    @results =Test.where(student_num: @student.num)
    @subjects =["英語", "数学", "国語", "理科", "社会", "美術", "技家", "音楽", "保体"]
    @terms =["1学期中間", "1学期期末", "2学期中間", "2学期期末", "学年末"]
    
    @resultsObj ={}
    #まずはひな型を作る
    @terms.each do |term|
      @resultsObj.store(term,{})
      @subjects.each do |subject|
        @resultsObj[term].store(subject,"")
      end
    end
    puts "ひな型、作成完了"

    #各スコアを入れ込んて行く
    @results.each do |result|
      if @year ==result.year
        term =result.term
        subject =result.subject
        score =result.score
        @resultsObj[term][subject] =score
      end
    end
    puts @resultsObj
  end


end
