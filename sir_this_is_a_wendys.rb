require 'cuba'

def well?
  'sure, man'
end

Cuba.define do
  on get do
    on root do
      res.write 'Sir, this is a Wendy\'s' + well?
    end
  end
end
