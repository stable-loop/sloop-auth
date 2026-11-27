class DocsController < ApplicationController
  layout "application", only: %i[landing pricing downloads about]

  def landing; end

  def about; end

  def pricing; end

  def downloads; end

  def index; end

  def songs; end

  def repertories; end

  def add_songs_to_repertories; end

  def events; end

  def lists; end

  def projector; end

  def screen_mirroring; end

  def remote_online; end

  def remote_offline; end
end
