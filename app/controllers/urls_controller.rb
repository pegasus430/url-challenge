# frozen_string_literal: true
class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.last(10)
  end

  def url_params
    params.require(:url).permit(:original_url)
  end

  def create
    short_url = (0...5).map { (65 + rand(26)).chr }.join
    url = Url.create({:short_url => short_url}.merge(url_params))

    redirect_to urls_path
  end

  def show
    @url = Url.where("short_url = ?", params[:url]).first
    url_id = @url.id
    # implement queries
    @daily_clicks = daily_clicks(url_id)
    @browsers_clicks = browsers_clicks(url_id)
    @platform_clicks = platform_clicks(url_id)
  end

  def visit
    logger.info "Processing the visit method..."
    url = Url.where("short_url = ?", params[:short_url]).first
    if url == nil
      redirect_to '/404'
    else 
      url.clicks_count = url.clicks_count + 1
      url.save
      
      browser = Browser.new(request.env['HTTP_USER_AGENT'], accept_language: "en-us")
      click = Click.create(url_id: url.id, browser: browser.name, platform: browser.platform.name)
      
      redirect_to url.original_url
    end
  end

  def not_found
    # render status: 404
  end

  def daily_clicks(url_id)
    day0 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today + 1, url_id).count
    day1 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today, url_id).count
    day2 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today - 1, url_id).count
    day3 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today - 2, url_id).count
    day4 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today - 3, url_id).count
    day5 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today - 4, url_id).count
    day6 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today - 5, url_id).count
    day7 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today - 6, url_id).count
    day8 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today - 7, url_id).count
    day9 = Click.where("DATE(created_at) = ? and url_id = ?", Date.today - 8, url_id).count

    return [
      ['1', day9],
      ['2', day8],
      ['3', day7],
      ['4', day6],
      ['5', day5],
      ['6', day4],
      ['7', day3],
      ['8', day2],
      ['9', day1],
      ['10', day0]
    ]
  end

  def browsers_clicks(url_id)

    ie = Click.where("url_id = ? AND browser = ?", url_id, 'IE').count
    firefox = Click.where("url_id = ? AND browser = ?", url_id, 'FireFox').count
    chrome = Click.where("url_id = ? AND browser = ?", url_id, 'Chrome').count
    safari = Click.where("url_id = ? AND browser = ?", url_id, 'Safari').count
    
    return [
      ['IE', ie],
      ['Firefox', firefox],
      ['Chrome', chrome],
      ['Safari', safari]
    ]
  end
  
  def platform_clicks(url_id)
    all = Click.where("url_id = ?", url_id).count
    windows = Click.where("url_id = ? AND platform = ?", url_id, 'Windows NT').count
    linux = Click.where("url_id = ? AND platform = ?", url_id, 'Generic Linux').count
    macOS = Click.where("url_id = ? AND platform = ?", url_id, 'macOS').count
    return [
      ['Windows', windows],
      ['macOS', macOS],
      ['Linux', linux],
      ['Other', all - windows - linux - macOS]
    ]
  end
end
