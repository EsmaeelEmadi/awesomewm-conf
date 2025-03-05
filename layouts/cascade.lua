local cascade = {}

-- Give the layout a name (displayed in the layoutbox)
cascade.name = "cascade"

-- Arrange all clients to use the same geometry
function cascade.arrange(p)
    local wa = p.workarea

    local visible_clients = {}
    for _, c in ipairs(p.clients) do
        if not c.minimized then
            table.insert(visible_clients, c)
        end
    end

    local margin = 10
    local offset = 10

    local new_width = math.max(wa.width - (#visible_clients * offset), 100)
    local new_height = math.max(wa.height - (#visible_clients * offset), 100)

    for i, c in ipairs(visible_clients) do
        local dx = (i - 1) * offset + (margin / 2)
        local dy = (i - 1) * offset + (margin / 2)

        c:geometry({
            x = wa.x + dx,
            y = wa.y + dy,
            width  = new_width,
            height = new_height
        })
    end
end

return cascade
