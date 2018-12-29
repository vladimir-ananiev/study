stack = []
def push(lexeme):
    stack.insert(0, lexeme)
#def push(lexemeType, lexemeText):
#    push((lexemeType, lexemeText))
def pop():
    if stack.count == 0:
        return None
    return stack.pop(0)
def peek():
    if stack.count == 0:
        return None
    return stack[0]

NotLexeme = ' '
def lexemeTypeFromChar(char):
    if char in '.0123456789':
        return 'n' # number
    if char in '+-*/()':
        return 'o' # operation
    if char in 'abcdefghijklmnopqrstuvwxyz':
        return 'f' # function
    return NotLexeme # not any lexeme
    
def extractLexems(expression):
    lexemes = []
    currentLexeme = (NotLexeme, '') # type and text
    for char in expression + ' ':
        lexemeType = lexemeTypeFromChar(char)
        isNextLexeme = not ((lexemeType == currentLexeme[0]) and (lexemeType in 'nf'))
        if isNextLexeme:
            if currentLexeme[0] != NotLexeme:
                lexemes.append(currentLexeme)
            currentLexeme = (lexemeType, str(char))
        else:
            if lexemeType != NotLexeme:
                currentLexeme = (currentLexeme[0], currentLexeme[1] + char)
    return lexemes
                
def buildRPN(lexemes):
    priority = {'+':1, '-':1, '*':2, '/':2}
    result = []
    for lexeme in lexemes:
        if lexeme[0] == 'n':
            result.append(lexeme)
        elif lexeme[0] == 'o':
            if lexeme[1] == '(':
                push(lexeme)
            elif lexeme[1] == ')':
                while (len(stack) != 0) and (peek()[1] != '('):
                    result.append(pop())
                pop() # '('
            else:
                while (len(stack) != 0) and (priority[lexeme[1]] <= priority[peek()[1]]) and (peek()[1] != '('):
                    result.append(pop())
                push(lexeme)
    while len(stack) != 0:
        result.append(pop())
    return result
    
lexemes = extractLexems(input())
print(lexemes)
rpn = buildRPN(lexemes)
print(rpn)
            
                
        