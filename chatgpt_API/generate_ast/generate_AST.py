import os
from antlr4 import * # type: ignore
from SolidityLexer import SolidityLexer
from SolidityParser import SolidityParser
# antlr4 -Dlanguage=Python3 -visitor JSON.g4
def main():
    # 读取 Solidity 源代码文件
    script_dir = os.path.dirname(os.path.abspath(__file__))
    api_key_path = os.path.join(script_dir, 'test.sol')
    input_stream = FileStream(api_key_path, encoding='utf-8')

    # 创建词法分析器和解析器
    lexer = SolidityLexer(input_stream)
    token_stream = CommonTokenStream(lexer)
    parser = SolidityParser(token_stream)

    # 生成解析树
    tree = parser.sourceUnit()

    # 打印解析树
    print(tree.toStringTree(recog=parser))

if __name__ == '__main__':
    main()

# from antlr4 import *
# from graphviz import Digraph
# from SolidityLexer import SolidityLexer
# from SolidityParser import SolidityParser
# from SolidityListener import SolidityListener

# class ASTVisualizer(SolidityListener):
#     def __init__(self):
#         self.graph = Digraph('AST', node_attr={'shape': 'plaintext'}, graph_attr={'rankdir': 'TB'})
#         self.node_count = 0

#     def enterEveryRule(self, ctx:ParserRuleContext):
#         self.node_count += 1
#         node_name = f'node{self.node_count}'
#         label = SolidityParser.ruleNames[ctx.getRuleIndex()]
#         self.graph.node(node_name, label)
        
#         if ctx.parentCtx is not None:
#             parent_name = f'node{ctx.parentCtx.nodeIndex + 1}'
#             self.graph.edge(parent_name, node_name)
        
#         ctx.nodeIndex = self.node_count

# def main():
#     input_stream = FileStream("test.sol", encoding='utf-8')
#     lexer = SolidityLexer(input_stream)
#     token_stream = CommonTokenStream(lexer)
#     parser = SolidityParser(token_stream)
#     tree = parser.sourceUnit()

#     visualizer = ASTVisualizer()
#     walker = ParseTreeWalker()
#     walker.walk(visualizer, tree)

#     visualizer.graph.render('ast', format='png', view=True)

# if __name__ == '__main__':
#     main()
