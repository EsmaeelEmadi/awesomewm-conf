local stacked = {}

-- Give the layout a name (displayed in the layoutbox)
stacked.name = "stacked"

-- Arrange all clients to use the same geometry
function stacked.arrange(p)
    local wa = p.workarea
    local clients = p.clients

    -- Set a margin if desired (in pixels)
    local margin = 0

    for _, c in ipairs(clients) do
        c:geometry({
            x = wa.x + margin,
            y = wa.y + margin,
            width  = math.max(wa.width  - 2 * margin, 100),  -- ensure a minimum width
            height = math.max(wa.height - 2 * margin, 100)   -- ensure a minimum height
        })
    end
end

return stacked
