//
//  BacklogUnitView+TableDelegate.swift
//  Board
//
//  Created by Anton Cherkasov on 03.09.2023.
//

import Cocoa

// MARK: - NSTableViewDelegate
extension BacklogUnitView: NSTableViewDelegate {

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let model = models[row]
		guard
			let identifier = tableColumn?.identifier,
			let configuration = makeConfiguration(model, column: identifier)
		else {
			return nil
		}
		return makeViewIfNeeded(tableView, configuration: configuration)
	}

	func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
		self.models = (models as NSArray).sortedArray(using: tableView.sortDescriptors) as! [BacklogRowModel]
		tableView.reloadData()
	}

}

// MARK: - Helpers
private extension BacklogUnitView {

	func makeViewIfNeeded<T: ViewConfiguration, View: ConfigurableView>(
		_ table: NSTableView, configuration: T
	) -> NSView? where T.View == View {
		let id = NSUserInterfaceItemIdentifier(View.reuseIdentifier)
		var view = table.makeView(withIdentifier: id, owner: self) as? View
		if view == nil {
			view = View(configuration)
			view?.identifier = id
		}
		view?.configure(configuration)
		return view
	}

	func makeConfiguration(_ item: BacklogRowModel, column: NSUserInterfaceItemIdentifier) -> (any ViewConfiguration)? {
		switch column {
		case .description:
			return TextItem(text: item.text) { [weak self] newText in
				self?.output?.fieldDidChange(description: newText, forId: item.id)
			}
		case .estimation:
			return TextItem(
				text: item.estimation,
				textColor: .secondaryLabelColor,
				alignment: .right
			)
		case .isUrgent:
			return ToggleItem(
				isEnable: item.isUrgent,
				image: "bolt.fill",
				alternativeImage: "bolt.fill",
				tintColor: .systemYellow) { [weak self] newFlag in
					self?.output?.fieldDidChange(urgentFlag: newFlag, forId: item.id)
				}
		default:
			return nil
		}
	}
}
