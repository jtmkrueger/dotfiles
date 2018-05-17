import datetime
import ephem

def get_phase_on_day():
  """Returns a symbolic value and name for the current moon phase"""

  date=ephem.Date(datetime.datetime.now())

  nnm = ephem.next_new_moon    (date)
  pnm = ephem.previous_new_moon(date)

  lunation=(date-pnm)/(nnm-pnm)

  if lunation >= 0 and lunation <= 0.125:
      return "🌚 new"
  elif lunation >= 0.126 and lunation <= 0.25:
      return "🌒 waxing crescent"
  elif lunation >= 0.26 and lunation <= 0.375:
      return "🌓 first quarter"
  elif lunation >= 0.376 and lunation <= 0.5:
      return "🌔 waxing gibbous"
  elif lunation >= 0.51 and lunation <= 0.625:
      return lunation
      return "🌝 full"
  elif lunation >= 0.626 and lunation <= 0.75:
      return "🌖 waning gibbous"
  elif lunation >= 0.76 and lunation <= 0.875:
      return "🌗 last quarter"
  elif lunation >= 0.876 and lunation <= 1.0:
      return "🌘 waning crescent"


def get_moons_in_year(year):
  """Returns a list of the full and new moons in a year. The list contains tuples
of either the form (DATE,'full') or the form (DATE,'new')"""
  moons=[]

  date=ephem.Date(datetime.date(year,1,1))
  while date.datetime().year==year:
    date=ephem.next_new_moon(date)
    moons.append( (date,'new') )

  #Note that previous_first_quarter_moon() and previous_last_quarter_moon()
  #are also methods

  moons.sort(key=lambda x: x[0])

  return moons

print(get_phase_on_day())

print(get_moons_in_year(2013))
