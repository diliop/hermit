/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

//! A mode for analyzing a hermit run to detect concurrency bugs.

mod minimize;
mod phases;
mod types;

pub use types::AnalyzeOpts;
pub use types::Report;
