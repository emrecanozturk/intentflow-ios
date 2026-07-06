# UIKit Example: Upload Retry Flow

This example keeps UIKit imperative, but moves product behavior out of the view controller.

It demonstrates:

- upload progress as explicit state
- cancellation through effect IDs
- weak captures around long-running async work
- observation token cleanup in `deinit`
- a projection layer that keeps the view controller focused on rendering

The view controller should be read as an adapter. The workflow can be tested without constructing UIKit at all.
