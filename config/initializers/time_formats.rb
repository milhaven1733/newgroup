Time::DATE_FORMATS[:default] = "%m/%d/%Y %I:%M %p"

Time::DATE_FORMATS.merge!(
  full: '%B %d, %Y at %I:%M %p',
  md: '%m/%d',
  mdy: '%m/%d/%y',
  time: '%I:%M %p'
)
