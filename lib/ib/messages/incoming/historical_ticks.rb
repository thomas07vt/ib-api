# HISTORICAL_TICKS          = 96
# HISTORICAL_TICKS_BID_ASK  = 97
# HISTORICAL_TICKS_LAST     = 98
module IB
  module Messages
    module Incoming

      # class AbstractHistoricalTick < AbstractMessage
      #   # Returns Symbol with a meaningful name for received tick type
      #   def type
      #     TICK_TYPES[@data[:tick_type]]
      #   end

      #   def to_human
      #     "<#{self.message_type} #{type}:" +
      #         @data.map do |key, value|
      #           " #{key} #{value}" unless [:version, :ticker_id, :tick_type].include?(key)
      #         end.compact.join('",') + " >"
      #   end

      #   def the_data
      #     @data.reject{|k,_| [:version, :ticker_id].include? k }
      #   end
      # end


      HistoricalTicks = def_message [96, 0],
        [:time, :int_date],
        [:mask, :int],
        [:price, :decimal],
        [:size, :decimal]

      # historicalTick = HistoricalTick()
      # historicalTick.time = decode(int, fields)
      # next(fields) # for consistency
      # historicalTick.price = decode(float, fields)
      # historicalTick.size = decode(int, fields)
      # ticks.append(historicalTick)
      HistoricalTicksBidAsk = def_message [97, 0],
        [:time, :int_date],
        [:mask, :int],
        [:bid_price, :decimal],
        [:ask_price, :decimal],
        [:bid_size, :int],
        [:ask_size, :int]

      # historicalTickBidAsk = HistoricalTickBidAsk()
      # historicalTickBidAsk.time = decode(int, fields)
      # mask = decode(int, fields)
      # tickAttribBidAsk = TickAttribBidAsk()
      # tickAttribBidAsk.askPastHigh = mask & 1 != 0
      # tickAttribBidAsk.bidPastLow = mask & 2 != 0
      # historicalTickBidAsk.tickAttribBidAsk = tickAttribBidAsk
      # historicalTickBidAsk.priceBid = decode(float, fields)
      # historicalTickBidAsk.priceAsk = decode(float, fields)
      # historicalTickBidAsk.sizeBid = decode(int, fields)
      # historicalTickBidAsk.sizeAsk = decode(int, fields)
      # ticks.append(historicalTickBidAsk)




      # def processHistoricalTicksLast(self, fields):
      #     next(fields)
      #     reqId = decode(int, fields)
      #     tickCount = decode(int, fields)

      #     ticks = []

      #     for _ in range(tickCount):
      #         historicalTickLast = HistoricalTickLast()
      #         historicalTickLast.time = decode(int, fields)
      #         mask = decode(int, fields)
      #         tickAttribLast = TickAttribLast()
      #         tickAttribLast.pastLimit = mask & 1 != 0
      #         tickAttribLast.unreported = mask & 2 != 0
      #         historicalTickLast.tickAttribLast = tickAttribLast
      #         historicalTickLast.price = decode(float, fields)
      #         historicalTickLast.size = decode(int, fields)
      #         historicalTickLast.exchange = decode(str, fields)
      #         historicalTickLast.specialConditions = decode(str, fields)
      #         ticks.append(historicalTickLast)

      #     done = decode(bool, fields)

      #     self.wrapper.historicalTicksLast(reqId, ticks, done)


      HistoricalTicksLast = def_message [98, 0],
        [:request_id, :int],
        [:tick_count, :int]
        # [:time, :int_date],
        # [:mask, :int],
        # [:price, :decimal],
        # [:size, :int],
        # [:exchange, :string],
        # [:special_conditions, :string]

      class HistoricalTicksLast
        attr_accessor :ticks

        using IBSupport  # extended Array-Class  from abstract_message

        def load
          super
          @ticks = []
          @data[:tick_count].times do |_|
            @ticks << IB::TickLast.new(
              :time => buffer.read_int_date,
              :mask => buffer.read_int,
              :price => buffer.read_decimal,
              :size => buffer.read_int,
              :exchange => buffer.read_string,
              :special_conditions => buffer.read_string
            )
          end
        end
      end

      # class HistoricalTickLast
      #   using IBSupport

      #   def load
      #     super
      #       load_map [:time, :decimal]

      #       # historicalTickLast = HistoricalTickLast()
      #       # historicalTickLast.time = decode(int, fields)
      #       # mask = decode(int, fields)
      #       # tickAttribLast = TickAttribLast()
      #       # tickAttribLast.pastLimit = mask & 1 != 0
      #       # tickAttribLast.unreported = mask & 2 != 0
      #       # historicalTickLast.tickAttribLast = tickAttribLast
      #       # historicalTickLast.price = decode(float, fields)
      #       # historicalTickLast.size = decode(int, fields)
      #       # historicalTickLast.exchange = decode(str, fields)
      #       # historicalTickLast.specialConditions = decode(str, fields)
      #       # ticks.append(historicalTickLast)
      #   end
      # end
    end
  end
end
