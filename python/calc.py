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

def add(n1, n2):
    return n1 + n2
def sub(n1, n2):
    return n1 - n2
def mul(n1, n2):
    return n1 * n2
def div(n1, n2):
    return n1 / n2
binaryOperations = {'+':add, '-':sub, '*':mul, '/':div}

NotLexeme = ' '
def lexemeTypeFromChar(char):
    if char in '.0123456789':
        return 'n'  # number
    if char in '+-*/()':
        return 'o'  # operation
    if char in 'abcdefghijklmnopqrstuvwxyz':
        return 'f'  # function
    return NotLexeme  # not any lexeme
    
def extractLexems(expression):
    result = []
    currentLexeme = (NotLexeme, '')  # type and text
    for char in expression + ' ':
        lexemeType = lexemeTypeFromChar(char)
        isNextLexeme = not ((lexemeType == currentLexeme[0]) and (lexemeType in 'nf'))
        if isNextLexeme:
            if currentLexeme[0] != NotLexeme:
                result.append(currentLexeme)
            currentLexeme = (lexemeType, str(char))
        else:
            if lexemeType != NotLexeme:
                currentLexeme = (currentLexeme[0], currentLexeme[1] + char)
    return result
                
def buildRPN(lexemes):
    priority = {'+': 1, '-': 1, '*': 2, '/': 2}
    result = []
    st = stack
    for lexeme in lexemes:
        if lexeme[0] == 'n':
            result.append(float(lexeme[1]))
        elif lexeme[0] == 'o':
            operation = lexeme[1]
            if operation == '(':
                push(operation)
            elif operation == ')':
                while peek() != '(':
                    result.append(pop())
                pop()  # '('
            else:
                while (not stackEmpty()) and (peek() != '(') and (priority[operation] <= priority[peek()]):
                    result.append(pop())
                push(operation)
    while not stackEmpty():
        result.append(pop())
    return result

def run(rpn):
    for item in rpn:
        if type(item) is float:
            push(item)
        else:
            n2 = pop()
            n1 = pop()
            operationResult = binaryOperations[item](n1, n2)
            push(operationResult)
    return pop()

while True:
    lexemes = extractLexems(input())
    print(lexemes)
    rpn = buildRPN(lexemes)
    print(rpn)
    result = run(rpn)
    print(result)
