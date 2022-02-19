const std = @import("std");
const mem = std.mem;
const atomic = std.atomic;

const bpf = @import("bpf");

export var events linksection("maps") = bpf.PerfEventArray.init(256, 0);

export fn bpf_prog(ctx: *bpf.SkBuff) linksection("socket1") c_int {
    var time = bpf.ktime_get_ns();
    events.event_output(ctx, bpf.F_CURRENT_CPU, mem.asBytes(&time)) catch {};
    return 0;
}
