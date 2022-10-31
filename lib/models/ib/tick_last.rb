module IB
  class TickLast < IB::Model
    include BaseProperties

    # historicalTickLast = HistoricalTickLast()
    # historicalTickLast.time = decode(int, fields)
    # mask = decode(int, fields)
    # tickAttribLast = TickAttribLast()
    # tickAttribLast.pastLimit = mask & 1 != 0
    # tickAttribLast.unreported = mask & 2 != 0
    # historicalTickLast.tickAttribLast = tickAttribLast
    # historicalTickLast.price = decode(float, fields)
    # historicalTickLast.size = decode(int, fields)
    # historicalTickLast.exchange = decode(str, fields)
    # historicalTickLast.specialConditions = decode(str, fields)
    # ticks.append(historicalTickLast)

    prop :time,
      :mask,
      :price,
      :size,
      :exchange,
      :special_conditions

  end
end

