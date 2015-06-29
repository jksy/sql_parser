module SqlParser
  class Select
    attr_reader :hint, :all, :select, :from, :where, :group
  
    def initialize(_hint, _all, _select, _from, _where, _group)
      @hint, @all, @select, @from, @where, @group = _hint, _all, _select, _from, _where, _group
    end

    def to_s
      "<#{self.class.to_s} :hint => #{hint}, :all => #{all}, :select => #{select}, :from => #{from}, :where => #{where}, :group => #{group}>"
    end
  end
end
