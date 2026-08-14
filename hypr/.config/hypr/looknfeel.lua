-- Change the default Omarchy look'n'feel.

hl.config({
  general = {
    gaps_in = 2,
    gaps_out = 3,
    border_size = 2,
  },
})

hl.config({
  decoration = {
    rounding = 8,

    blur = {
      enabled = true,
      size = 1,
      passes = 2,
      ignore_opacity = true,
    },
  },
})

hl.config({
  animations = {
    enabled = true,
  },
})

-- https://wiki.hypr.land/Configuring/Basics/Variables/#layout
-- hl.config({
--   layout = {
--     -- Avoid overly wide single-window layouts on wide screens.
--     single_window_aspect_ratio = { 1, 1 },
--   },
-- })

-- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- hl.config({
--   scrolling = {
--     -- See only one column per screen instead of two.
--     column_width = 0.97,
--   },
-- })
