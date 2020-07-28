--[[
TIPS:
1 天书需要输入完整，即外围的包围的符号全部都需要。
]]--

local allColde = {'零', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '百', '千', '万', '亿', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖', '拾', '佰', '仟', '点', '天', '年', '时', '辰', '武', '学', '道', '行', '潜', '能', '奖', '盒', '□', '某', '几', '乎', '是', '加', '减', '乘', '除'}
local upperDigit = {'零', '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '百', '千', '万', '亿'}
local chineseDigit = {'零', '壹', '贰', '叁', '肆', '伍', '陆', '柒', '捌', '玖', '拾', '佰', '仟', '万', '亿'}
local lowerDigit = {'', '', '', '', '', '', '', '', '', ''}
local unitChar = {'点', '天', '年', '时辰'}
local gainChar = {'武', '学', '道', '行', '潜', '能'}
--[[武学pattern
]]--
--[[
废词:几乎，几(统统取五)，某(统统取五)
奖盒二□多于四白减几乎是一百点潜能
奖盒一□十几加上负的几年二百四十八天六时辰道行
奖盒三□七某某点武学
奖盒一□六十一天六时辰道行
]]--
local dat1 = [[………………………………………………………………………………………………………………
…               奖                                                                …
…                盒                                             奖                …
…            奖   一  奖                                奖      盒                …
…            盒   □  盒                               盒       四                …
…           四    某  三                               一    奖奖                 …
…           □   奖盒四□十一两黄金五两白银            □       盒                …
…                                                     负         一               …
…奖       奖         奖                              辰     奖   □           奖  …
…盒        盒         盒                             道   奖盒   四          奖   …
…三        三         一                            武   盒  三   千          盒  …
…□        □          □      奖                   □  四    □  四  奖       奖 …
…四         四          七     盒                  十  □    奖一  百          盒 …
…千         千         奖  奖盒三□七某某点武学   十  气       二   八          四…
…三         八         盒                        学             一   十           …
…百         百         四                        辰                  七           …
…八     奖   二        □ 奖                                         一  奖 奖    …
…十     盒    十       三     奖   奖                                 百    盒    …
…六     一    七       千     盒   盒                                  零   一    …
…二     □    十       零     二   四                奖                四  □     …
…十     学    七       八  奖盒一□六十一天六时辰道行             奖    七        …
…   奖  某    五       十                                        盒      十       …
…  盒   学     十      一                                       一        三      …
…  三   二      三     八                          奖          □          两     …
… □    时       某    十                         奖盒        某           学   奖…
… 点    一        武   四             奖            三       武            学   盒…
… 道    盒         六  九       奖盒二□负的二某某某点火气  某              点  一…
… 某               一  十                                 奖奖               六   …
… 五               奖  二                                  白                 某  …
…盒                点  某奖                奖             □               奖 二  …
… 奖       奖     奖   某                 盒  奖          某                  □  …
………………………………………………………………………………………………………………]]

function Split(szFullString, szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
	   if not nFindLastIndex then
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
		break
	   end
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)
	   nSplitIndex = nSplitIndex + 1
	end
	return nSplitArray
end

local result = Split(dat1, '\n')
local s={}
local mark={}
local wu={}
local xue={}
local dao={}
local heng={}
local qian={}
local neng={}
local gainTable={wu, xue, dao, heng, qian, neng}


local findGainCharPos = function(ch, t2, a, b)
    for k,v in ipairs(gainChar) do
        if (v == ch) then
            table.insert(t2[k], {a, b})
        end
    end
end

for k,v in ipairs(result) do
        local t={}
        for i = 1, string.len(v) - 1  do
            t[i] = string.sub(v, i, i+1)
        end
        s[k] = t
end

for k,v in ipairs(s) do
    -- print (k, type(v), v)
    local t={}
    for i = 1, #v do
        -- if ( string.byte(v[i], 1)>127 and string.byte(v[i], 2)>127 ) then
        local flag = false
        for j = 1, #allColde do
            if ( allColde[j] == v[i] ) then
                flag = true
                findGainCharPos(v[i], gainTable, k, i)
            end
        end
        t[i] = flag
    end
    mark[k] = t
end

-- for k,v in ipairs(s) do
    -- for i = 1, #v do
        -- if (mark[k][i] == true and v[i] == gainChar[1]) then
            -- table.insert(wu, {k, i})
        -- end
    -- end
-- end

local findGainStrPos = function(t1, t2)
    local res = {}
    for i = 1, #t1 do
        for j = 1, #t2 do
            if (math.abs(t1[i][1]-t2[j][1]) <=2 and math.abs(t1[i][2]-t2[j][2]) <= 2) then
                table.insert(res, {t1[i][1], t1[i][2], math.abs(t1[i][1]-t2[j][1]), math.abs(t1[i][2]-t2[j][2])})
            end
        end
    end    
    return res
end

--1 横向  0 竖向
local direction = {0,0,0}

local wuxue = findGainStrPos(gainTable[1], gainTable[2])
for k,v in ipairs(wuxue) do
    -- print (#wuxue, v[1], v[2])
    if (v[3] < v[4]) then
        direction[1] = 1
    else
        direction[1] = 0
    end
end

local daoheng = findGainStrPos(gainTable[3], gainTable[4])
for k,v in ipairs(daoheng) do
    -- print (#daoheng, v[1], v[2])
    if (v[3] < v[4]) then
        direction[2] = 1
    else
        direction[2] = 0
    end
end


local directionFinal = direction[1]
local wx_result = {}
findGainStr  = function(inStr, row, column)
-- 搜索到边界就不要继续搜索了
    if ((row == 1) or (column == 1) or (row == #s) or (colum == #s[1])) then
        -- print (inStr)
        table.insert(wx_result, inStr)
        return
    end
    
    local flag = false
    
    if directionFinal == 1 then
        for i = 1, 2, 1 do
            if mark[row-1][column-i] == true then
                findGainStr(s[row-1][column-i] .. inStr, row-1, column-i)
                flag = true
            end
        end
        for i = 1, 2, 1 do
            if mark[row+1][column-i] == true then
                findGainStr(s[row+1][column-i] .. inStr, row+1, column-i)
                flag = true
            end
        end
        if mark[row][column-2] == true then
            findGainStr(s[row][column-2] .. inStr, row, column-2)
            flag = true
        end
    else
    
    end
    
    if flag == false then
        -- print (inStr)
        table.insert(wx_result, inStr)
    end
end

findGainStr('武学', wuxue[1][1], wuxue[1][2])
-- findGainStr('道行', daoheng[1][1], daoheng[1][2])

for k,v in ipairs(wx_result) do
    print (k, v)
    for k1, v1 in string.gmatch(v, '奖盒(.*)□(.*)点武学') do 
        print(k1, v1)
    end
end


