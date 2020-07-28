--[[
TIPS:
1 ������Ҫ��������������Χ�İ�Χ�ķ���ȫ������Ҫ��
]]--

local allColde = {'��', 'һ', '��', '��', '��', '��', '��', '��', '��', '��', 'ʮ', '��', 'ǧ', '��', '��', 'Ҽ', '��', '��', '��', '��', '½', '��', '��', '��', 'ʰ', '��', 'Ǫ', '��', '��', '��', 'ʱ', '��', '��', 'ѧ', '��', '��', 'Ǳ', '��', '��', '��', '��', 'ĳ', '��', '��', '��', '��', '��', '��', '��'}
local upperDigit = {'��', 'һ', '��', '��', '��', '��', '��', '��', '��', '��', 'ʮ', '��', 'ǧ', '��', '��'}
local chineseDigit = {'��', 'Ҽ', '��', '��', '��', '��', '½', '��', '��', '��', 'ʰ', '��', 'Ǫ', '��', '��'}
local lowerDigit = {'', '', '', '', '', '', '', '', '', ''}
local unitChar = {'��', '��', '��', 'ʱ��'}
local gainChar = {'��', 'ѧ', '��', '��', 'Ǳ', '��'}
--[[��ѧpattern
]]--
--[[
�ϴ�:��������(ͳͳȡ��)��ĳ(ͳͳȡ��)
���ж��������İ׼�������һ�ٵ�Ǳ��
����һ��ʮ�����ϸ��ļ��������ʮ������ʱ������
����������ĳĳ����ѧ
����һ����ʮһ����ʱ������
]]--
local dat1 = [[������������������������������������������������������������������������������������
��               ��                                                                ��
��                ��                                             ��                ��
��            ��   һ  ��                                ��      ��                ��
��            ��   ��  ��                               ��       ��                ��
��           ��    ĳ  ��                               һ    ����                 ��
��           ��   �����ġ�ʮһ���ƽ���������            ��       ��                ��
��                                                     ��         һ               ��
����       ��         ��                              ��     ��   ��           ��  ��
����        ��         ��                             ��   ����   ��          ��   ��
����        ��         һ                            ��   ��  ��   ǧ          ��  ��
����        ��          ��      ��                   ��  ��    ��  ��  ��       �� ��
����         ��          ��     ��                  ʮ  ��    ��һ  ��          �� ��
��ǧ         ǧ         ��  ����������ĳĳ����ѧ   ʮ  ��       ��   ��          �ġ�
����         ��         ��                        ѧ             һ   ʮ           ��
����         ��         ��                        ��                  ��           ��
����     ��   ��        �� ��                                         һ  �� ��    ��
��ʮ     ��    ʮ       ��     ��   ��                                 ��    ��    ��
����     һ    ��       ǧ     ��   ��                                  ��   һ    ��
����     ��    ʮ       ��     ��   ��                ��                ��  ��     ��
��ʮ     ѧ    ��       ��  ����һ����ʮһ����ʱ������             ��    ��        ��
��   ��  ĳ    ��       ʮ                                        ��      ʮ       ��
��  ��   ѧ     ʮ      һ                                       һ        ��      ��
��  ��   ��      ��     ��                          ��          ��          ��     ��
�� ��    ʱ       ĳ    ʮ                         ����        ĳ           ѧ   ����
�� ��    һ        ��   ��             ��            ��       ��            ѧ   �С�
�� ��    ��         ��  ��       ���ж������Ķ�ĳĳĳ�����  ĳ              ��  һ��
�� ĳ               һ  ʮ                                 ����               ��   ��
�� ��               ��  ��                                  ��                 ĳ  ��
����                ��  ĳ��                ��             ��               �� ��  ��
�� ��       ��     ��   ĳ                 ��  ��          ĳ                  ��  ��
������������������������������������������������������������������������������������]]

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

--1 ����  0 ����
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
-- �������߽�Ͳ�Ҫ����������
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

findGainStr('��ѧ', wuxue[1][1], wuxue[1][2])
-- findGainStr('����', daoheng[1][1], daoheng[1][2])

for k,v in ipairs(wx_result) do
    print (k, v)
    for k1, v1 in string.gmatch(v, '����(.*)��(.*)����ѧ') do 
        print(k1, v1)
    end
end


