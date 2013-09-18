class PagesController < ApplicationController
  def main
    if not signed_in?
      redirect_to root_path
    end
  end
end
