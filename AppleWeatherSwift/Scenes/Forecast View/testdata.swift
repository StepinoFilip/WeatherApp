//
//  testdata.swift
//  AppleWeatherSwift
//
//  Created by Filip Štěpánek on 16.12.2023.
//

import SwiftUI

struct testdata: View {
    let unixTimestamp = 1702749600

    var body: some View {
        VStack {
            Text("Unix Timestamp: \(unixTimestamp)")
            FormattedDateView(unixTimestamp: unixTimestamp)
        }
        .padding()
    }
}

struct FormattedDateView: View {
    let unixTimestamp: Int

    var body: some View {
        let formattedDate = formatUnixTimestamp(unixTimestamp)

        return Text("Formatted Date: \(formattedDate)")
    }

    private func formatUnixTimestamp(_ timestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        return dateFormatter.string(from: date)
    }
}

struct testdata_Previews: PreviewProvider {
    static var previews: some View {
        testdata()
    }
}
