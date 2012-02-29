require 'wcnh'

module RP
  PennJSON::register_object(self)
  R = PennJSON::Remote
  
  def self.pj_toc
    self.toc
  end
  
  def self.pj_create(category, title, info, creator)
    self.create(category, title, info, creator)
  end
  
  def self.pj_view(id)
    self.view(id)
  end
  
  def self.pj_index(category, page=1)
    self.index(category, page)
  end
  
  def self.pj_search(term)
    self.search(term)
  end
  
  def self.pj_top
    self.top
  end
  
  def self.pj_recent(hours)
    self.recent(hours)
  end
  
  def self.pj_remove(num)
    self.remove(num)
  end
  
  def self.pj_vote(num, voter)
    self.vote(num, voter)
  end
  
  def self.pj_decay
    self.decay
  end
end
