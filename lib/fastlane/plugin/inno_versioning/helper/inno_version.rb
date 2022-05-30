class Version
  #value stores like "1.0(1)"
  attr_accessor :minor, :major, :patch, :build

  def initialize(major, minor, patch, build)
    # assign instance avriables
    @major, @minor, @patch, @build = major, minor, patch, build
  end

  def self.parse(parsed)
    #TODO: впилить проверку на правильный формат
    {'beta' => self.parse_beta(parsed), 'rc' => self.parse_rc(parsed), 'release' => self.parse_release(parsed)}
  end

  def to_s
    self.toString
  end

  def self.parse_beta(parsed)
    beta_version = parsed["beta"]
    self.parse_string(beta_version)
  end

  def self.parse_rc(parsed)
    rc_version = parsed["rc"]
    self.parse_string(rc_version)
  end

  def self.parse_release(parsed)
    release_version = parsed["release"]
    self.parse_string(release_version)
  end

  def self.parse_string(str)
    # puts('Parsing version str ' + str)
    v_elements = str.split(pattern='.')
    build_value = v_elements[1].split(pattern='(')[1].split(pattern=')')[0]
    Version.new(v_elements[0].to_i, v_elements[1].to_i, v_elements[2].to_i, build_value.to_i)
  end

  def <= (other)
    if @major < other.major
      return true
    elsif @major == other.major && @minor < other.minor
      return true
    elsif @major == other.major && @minor == other.minor && @patch < other.patch
      return true
    elsif @major == other.major && @minor == other.minor && @patch == other.patch && @build < other.build
      return true
    elsif @major == other.major && @minor == other.minor && @patch == other.patch && @build == other.build
      return true
    end
    false
  end

  def toString
    res = @major.to_s + '.' + @minor.to_s + + '.' + @patch.to_s + '(' + @build.to_s + ')'
  end
end