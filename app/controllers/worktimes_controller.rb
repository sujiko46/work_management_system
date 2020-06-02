require 'date'
class WorktimesController < ApplicationController
  def history
  end

  def list
    @works = Worktime.list(session[:user_id], params[:worktime][:month], params[:worktime][:year])
    @month = params[:worktime][:month]
      #binding.pry
  end

  def entry
    @info = Worktime.find(params[:id])
  end

  def new
    #lastがnilの時の処理を書こう
    @last_worktime = Worktime.find_by(user_id: session[:user_id],
                                    year: Time.now.strftime("%Y"),
                                    month: Time.now.strftime("%m"),
                                    day: Time.now.strftime("%d"))
    @today = Time.now.strftime("%Y年%m月%d日")
    @yesterday = Time.now.yesterday
    #@last_worktime.nil?
    if @last_worktime.nil? || @last_worktime.last.in_time.strftime("%Y年%m月%d日") != @today
      @worktime = Worktime.new(user_id: session[:user_id],
                               in_time: Time.now,
                               year: Time.now.strftime("%Y"),
                               month: Time.now.strftime("%m"),
                               day: Time.now.strftime("%d"))
      @worktime.save
      flash[:success] = '出勤時間を登録しました'
      redirect_to current_user
    else
      flash[:notice] = 'すでに本日分は登録済みです'
      redirect_to current_user
    end

    # 書き込み条件
    # user_idがsession[:user_id]かつ年月日がTime.nowと同じデータがない場合
    #
  end

  def update
    #binding.pry
    @worktime = Worktime.find_by(user_id: session[:user_id],
                               year: Time.now.strftime("%Y"),
                               month: Time.now.strftime("%m"),
                               day: Time.now.strftime("%d"))
    if @worktime.nil?
      flash[:fail] = '先に出勤してください'
      redirect_to current_user
    elsif @worktime.out_time.nil?
      @worktime.out_time = Time.now
      @worktime.save
      flash[:success] = '退勤時間を登録しました。お疲れさまでした'
      redirect_to current_user
    else
      flash[:notice] = 'すでに本日分は登録済みです'
      redirect_to current_user
    end
    # 書き込み条件
    # find（user_id: current_user.id）したデータのout_timeがnil



  end

end
