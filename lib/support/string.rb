class String
  def to_bool
    return true if self =~ (/^(checked|true|t|yes|y|1)$/i)
    return false if self.empty? || self =~ (/^(unchecked|false|f|no|n|0)$/i)

    raise ArgumentError.new "invalid value for boolean: #{self}"
  end
end