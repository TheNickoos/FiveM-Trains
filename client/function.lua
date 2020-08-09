function removebyKey(tab, val)
    for i, v in ipairs (tab) do 
        if (v == val) then
          tab[i] = nil
        end
    end
end