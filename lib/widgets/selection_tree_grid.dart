
import 'package:flutter/material.dart';

import '../features/clothing/domain/clothing_type.dart';

class TreeSelection<T extends IconMapper> extends StatelessWidget {
  final List<SelectionTreeItem<T>> selectionItems;

  const TreeSelection(this.selectionItems, {super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (context) => TreeSelectionSubScreen(selectionItems),
          );
        }
    );
  }
}

class TreeSelectionSubScreen<T extends IconMapper> extends StatelessWidget {
  final List<SelectionTreeItem<T>> selectionItems;

  const TreeSelectionSubScreen(this.selectionItems, {super.key});

  @override
  Widget build(BuildContext context) {
    void onItemTap(SelectionTreeItem item) {
      if (item is SelectionNode) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>
                TreeSelectionSubScreen(item.getChildren())));
      } else if (item is SelectionItem) {
        Navigator.pop(context, item.getValue());
      }
    }

    return LayoutBuilder(
          builder: (context, constraints) {
            // Calculate the number of columns based on the available width
            int columns = (constraints.maxWidth / 150).floor();
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                childAspectRatio: 1,
              ),
              itemCount: selectionItems.length,
              itemBuilder: (context, index) {
                final item = selectionItems[index];
                return GestureDetector(
                  onTap: () => onItemTap(item),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(item.getIcon(), size: 50),
                      const SizedBox(height: 8),
                      Text(item.toString()),
                    ],
                  ),
                );
              },
            );
          },
        );
  }

}

abstract class SelectionTreeItem<T extends IconMapper> with IconMapper {
  const SelectionTreeItem();
}

class SelectionNode<T extends IconMapper> extends SelectionTreeItem<T>
    with IconMapper {
  final List<SelectionTreeItem<T>> children;
  final String label;
  final IconData icon;

  const SelectionNode({required this.children, required this.label, required this.icon});

  List<SelectionTreeItem<T>> getChildren() {
    return children;
  }

  @override
  IconData getIcon() {
    return icon;
  }

  @override
  String toString() {
    return label;
  }
}

class SelectionItem<T extends IconMapper> extends SelectionTreeItem<T>
    with IconMapper {
  final T value;

  const SelectionItem(this.value);

  T getValue() {
    return value;
  }

  @override
  IconData getIcon() {
    return value.getIcon();
  }

  @override
  String toString() {
    return value.toString();
  }
}