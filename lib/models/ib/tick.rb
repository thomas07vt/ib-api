module IB
  class Tick < IB::Model
    include BaseProperties

    prop :time,
      :mask,
      :price,
      :size,
      :exchange,
      :special_conditions

  end
end
