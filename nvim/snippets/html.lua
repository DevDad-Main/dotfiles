---@diagnostic disable: undefined-global

local function tag(name)
  return s({ trig = name, priority = 2000 }, {
    t("<" .. name .. ">"),
    i(1),
    t("</" .. name .. ">"),
  })
end

local function void_tag(name)
  return s({ trig = name, priority = 2000 }, {
    t("<" .. name .. " />"),
  })
end

return {
  tag("div"),
  tag("span"),
  tag("p"),
  tag("a"),
  tag("button"),
  tag("h1"),
  tag("h2"),
  tag("h3"),
  tag("h4"),
  tag("h5"),
  tag("h6"),
  tag("ul"),
  tag("ol"),
  tag("li"),
  tag("section"),
  tag("article"),
  tag("header"),
  tag("footer"),
  tag("nav"),
  tag("main"),
  tag("aside"),
  tag("form"),
  tag("label"),
  tag("textarea"),
  tag("select"),
  tag("option"),
  tag("table"),
  tag("thead"),
  tag("tbody"),
  tag("tfoot"),
  tag("tr"),
  tag("td"),
  tag("th"),
  tag("strong"),
  tag("em"),
  tag("small"),
  tag("code"),
  tag("pre"),
  tag("blockquote"),
  tag("figure"),
  tag("figcaption"),
  void_tag("img"),
  void_tag("input"),
  void_tag("br"),
  void_tag("hr"),
  void_tag("link"),
  void_tag("meta"),
}