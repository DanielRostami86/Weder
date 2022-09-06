//
//  Enums.swift
//  Networking
//
//  Created by Daniel Rostami on 15/8/2022.
//

import Foundation

enum DateStringFormatTo: String {
    case YYYY_MM_DD = "YYYY MM dd"
    case dd_MMM_yyyy = "dd MMM YYYY"
    case dd_MMM_yyyy_hh_mm = "MM dd yyyy HH:mm:ss"
    case yyyy_MM_dd_hh_mm = "yyyy MM dd HH:mm:ss"
    case hh_mm = "HH:mm:ss"
}

enum DateStringFormatFrom: String {
    case YYYY_MM_DD = "YYYY-MM-dd"
    case dd_MMM_yyyy = "dd-MMM-YYYY"
    case YYYY_MM_DD_T_HH_MM_SS_SSS_Z = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss"

}
