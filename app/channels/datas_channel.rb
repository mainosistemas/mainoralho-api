class DatasChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'datas'
  end
end
