# HISTORICAL_TICKS          = 96
# HISTORICAL_TICKS_BID_ASK  = 97
# HISTORICAL_TICKS_LAST     = 98
module IB
  module Messages
    module Incoming

      class AbstractHistoricalTick < AbstractMessage
        # Returns Symbol with a meaningful name for received tick type
        def type
          TICK_TYPES[@data[:tick_type]]
        end

        def to_human
          "<#{self.message_type} #{type}:" +
              @data.map do |key, value|
                " #{key} #{value}" unless [:version, :ticker_id, :tick_type].include?(key)
              end.compact.join('",') + " >"
        end

        def the_data
          @data.reject{|k,_| [:version, :ticker_id].include? k }
        end
      end


      HistoricalTickByTick = def_message [96, 0], AbstractTick
      HistoricalTickBidAsk = def_message [97, 0], AbstractTick
      HistoricalTickLast = def_message [98, 0], AbstractTick
    end
  end
end
