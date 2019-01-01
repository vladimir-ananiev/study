import math

stack = []
def stackEmpty():
    return len(stack) == 0
def push(item):
    stack.insert(0, item)
def pop():
    if stackEmpty():
        return None
    return stack.pop(0)
def peek():
    if stackEmpty():
        return None
    return stack[0]

def opAdd(n1, n2):
    return n1 + n2
def opSub(n1, n2):
    return n1 - n2
def opMul(n1, n2):
    return n1 * n2
def opDiv(n1, n2):
    return n1 / n2
def opPow(n1, n2):
    return n1 ** n2
binaryOperations = {'+':opAdd, '-':opSub, '*':opMul, '/':opDiv, '^':opPow}

unaryFunctions = {'abs':abs
                  , 'round':round
                  , 'fabs':math.fabs
                  , 'ceil':math.ceil
                  , 'floor':math.floor
                  , 'trunc':math.trunc
                  , 'factorial':math.factorial
                  , 'exp':math.exp
                  , 'sin':math.sin
                  , 'cos':math.cos
                  , 'tan':math.tan}

NotLexeme = ' '
def lexemeTypeFromChar(char):
    if char in '.0123456789':
        return 'n'  # number
    if char in 'abcdefghijklmnopqrstuvwxyz':
        return 'f'  # function with one argument
    if char in '+-*/^()':
        return char
    return NotLexeme  # not any lexeme
    
def extractLexems(expression):
    expression = ('(' + expression.replace(' ', '') + ')').replace('(-', '(0-') + ' '
    result = []
    currentLexeme = NotLexeme
    for char in expression:
        lexemeType = lexemeTypeFromChar(char)
        isNextLexeme = not ((lexemeType == currentLexeme[0]) and (lexemeType in 'nf'))
        if isNextLexeme:
            if currentLexeme[0] != NotLexeme:
                result.append(currentLexeme)
            if lexemeType in 'nf':
                currentLexeme = str(lexemeType) + char
            else:
                currentLexeme = char
        elif lexemeType != NotLexeme:
                currentLexeme += char
    return result
                
def buildRPN(lexemes):
    priority = {'+': 1, '-': 1, '*': 2, '/': 2, '^': 3}
    result = []
    stack.clear()
    for lexeme in lexemes:
        lexemeType = lexeme[0]
        if lexemeType == 'n':
            result.append(float(lexeme[1:]))
            continue
        if lexemeType == 'f':
            push(lexeme)
            continue
        if lexemeType == '(':
            push(lexemeType)
            continue
        if lexemeType == ')':
            while (not stackEmpty()) and (peek() != '('):
                result.append(pop())
            pop()  # '('
            continue
        operation = lexemeType
        while not stackEmpty():
            stackTop = peek()
            if stackTop == '(':
                break
            if stackTop[0] == 'f':
                result.append(pop())
                continue
            stackTopPriority = priority[stackTop]
            operationPriority = priority[operation]
            if (stackTopPriority > operationPriority):
                result.append(pop())
                continue
            if ((stackTopPriority == operationPriority) and (stackTop in '+-*/')):
                result.append(pop())
                continue
            break
        push(operation)
    while not stackEmpty():
        result.append(pop())
    return result

def run(rpn):
    stack.clear()
    for item in rpn:
        if type(item) is float:
            push(item)
        elif item[0] == 'f':
            number = pop()
            functionName = item[1:]
            push(unaryFunctions[functionName](number))
        else:
            number2 = pop()
            number1 = pop()
            push(binaryOperations[item](number1, number2))
    return pop()

testExpressions = [
    ('2.', '1+1.1')
    , ('.1', '.1')
    , ('10', '1+2+3+4')
    , ('9', '3*(2+1)')
    , ('11.9', '3.5 * (2+1.4)')
    , ('25', '100 / 4 / 5 * (9-6) + 5 - (1-2)*5')
    , ('10001', '100.01 * (99+1)')
    , ('1.1', '1.11')
    , ('149883145', '653869*226+(971*681)-(127-416+868)*(745-870)*20')
    , ('71170.0595', '(659/622)-643-269-(132-366)*456-(492*74-857)+928')
    , ('652.8095', '72+(288/295)*488-364*(299/859)+221+(301+708)/100')
    , ('-125054', '151/(540-36-776)/(537*781)/351+(182-162*773-10)')
    , ('80749158127.008', '(299*852)-(342/710+820*46)*137+563*(687*449)*465')
    , ('2725530989', '(473-411)*(213+120)*149*886+133-(918*33)+106')
    , ('767.5806', '(660+108)+(21-657+846+612)/24/214+(487-859)/642')
    , ('513.9824', '(736+664-825-378)+(440-864)-6+747-(932/65)/815')
    , ('0.2247', '153/681+(374/150)/(272/329+745*169)/(341/209+471)')
    , ('-1546006.0427', '12*(606-942*249)*(201/365)+870/(131*129+946-611)')
    # , ('513.9824', '(736+664-825-378)+(440-864)-6+747-(932/65)/815')
    # , ('513.9824', '(736+664-825-378)+(440-864)-6+747-(932/65)/815')
    # , ('513.9824', '(736+664-825-378)+(440-864)-6+747-(932/65)/815')
    # , ('513.9824', '(736+664-825-378)+(440-864)-6+747-(932/65)/815')
    # , ('513.9824', '(736+664-825-378)+(440-864)-6+747-(932/65)/815')
    # , ('513.9824', '(736+664-825-378)+(440-864)-6+747-(932/65)/815')
    # , ('513.9824', '(736+664-825-378)+(440-864)-6+747-(932/65)/815')
]

for te in testExpressions:
    res = run(buildRPN(extractLexems(te[1])))
    decimals = 0
    pointAt = te[0].find('.')
    if pointAt != -1:
        decimals = len(te[0]) - pointAt - 1
    roundedResult = round(res, decimals)
    if float(te[0]) == roundedResult:
        print('OK:', te[0], '==', te[1])
    else:
        print('Fail:', te[0], '!=', roundedResult, te[1])
        print(pointAt, decimals, len(te[0]))

while True:
    expression = input()
    if len(expression) == 0:
        break
    lexemes = extractLexems(expression)
    print(lexemes)
    rpn = buildRPN(lexemes)
    print(rpn)
    result = run(rpn)
    print(result)
