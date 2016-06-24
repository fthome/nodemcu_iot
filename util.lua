function _dofile(prog)
    local files = file.list()
    if files[prog..".lua"] then
        return dofile(prog..".lua")
    elseif  files[prog..".lc"] then
        return dofile(prog..".lc")
    else
        print("file "..prog.." doesn't existe!")
    end
end
        