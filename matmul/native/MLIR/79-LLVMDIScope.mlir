// --enable-line-info
// LLVMDIScope ('builtin.module' operation)

; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"
target datalayout = "e-p3:32:32-p4:32:32-p5:32:32-p6:32:32-p7:32:32-i64:64-i128:128-v16:16-v32:32-n16:32:64"

@global_smem = external local_unnamed_addr addrspace(3) global [0 x i8], align 16

define ptx_kernel void @matrix_multiplication_kernel(ptr addrspace(1) %0, ptr addrspace(1) %1, ptr addrspace(1) %2, i32 %3, i32 %4, i32 %5, i32 %6, i32 %7, i32 %8, ptr addrspace(1) readnone captures(none) %9) local_unnamed_addr #0 !dbg !5 {
  %11 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.x(), !dbg !8
  %12 = tail call i32 @llvm.nvvm.read.ptx.sreg.ctaid.y(), !dbg !9
  %13 = shl nuw nsw i32 %12, 7, !dbg !10
  %14 = tail call i32 @llvm.nvvm.read.ptx.sreg.tid.x(), !dbg !11
  %15 = and i32 %14, 127, !dbg !11
  %16 = or disjoint i32 %13, %15, !dbg !12
  %17 = shl i32 %11, 6, !dbg !13
  %18 = mul i32 %6, %16, !dbg !14
  %19 = sext i32 %18 to i64, !dbg !15
  %20 = getelementptr float, ptr addrspace(1) %0, i64 %19, !dbg !15
  %21 = sext i32 %17 to i64, !dbg !16
  %22 = getelementptr float, ptr addrspace(1) %1, i64 %21, !dbg !16
  %23 = getelementptr i8, ptr addrspace(1) %22, i64 16, !dbg !16
  %24 = getelementptr i8, ptr addrspace(1) %22, i64 32, !dbg !16
  %25 = getelementptr i8, ptr addrspace(1) %22, i64 48, !dbg !16
  %26 = getelementptr i8, ptr addrspace(1) %22, i64 64, !dbg !16
  %27 = getelementptr i8, ptr addrspace(1) %22, i64 80, !dbg !16
  %28 = getelementptr i8, ptr addrspace(1) %22, i64 96, !dbg !16
  %29 = getelementptr i8, ptr addrspace(1) %22, i64 112, !dbg !16
  %30 = getelementptr i8, ptr addrspace(1) %22, i64 128, !dbg !16
  %31 = getelementptr i8, ptr addrspace(1) %22, i64 144, !dbg !16
  %32 = getelementptr i8, ptr addrspace(1) %22, i64 160, !dbg !16
  %33 = getelementptr i8, ptr addrspace(1) %22, i64 176, !dbg !16
  %34 = getelementptr i8, ptr addrspace(1) %22, i64 192, !dbg !16
  %35 = getelementptr i8, ptr addrspace(1) %22, i64 208, !dbg !16
  %36 = getelementptr i8, ptr addrspace(1) %22, i64 224, !dbg !16
  %37 = getelementptr i8, ptr addrspace(1) %22, i64 240, !dbg !16
  %38 = icmp sgt i32 %4, 0, !dbg !17
  br i1 %38, label %.lr.ph.preheader, label %._crit_edge, !dbg !17

.lr.ph.preheader:                                 ; preds = %10
  %wide.trip.count = zext nneg i32 %4 to i64, !dbg !17
  br label %.lr.ph, !dbg !17

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %indvars.iv = phi i64 [ 0, %.lr.ph.preheader ], [ %indvars.iv.next, %.lr.ph ]
  %39 = phi <64 x float> [ zeroinitializer, %.lr.ph.preheader ], [ %210, %.lr.ph ]
  %40 = getelementptr float, ptr addrspace(1) %20, i64 %indvars.iv, !dbg !18
  %41 = tail call i32 asm sideeffect "mov.u32 $0, 0x0;\0A\09ld.global.b32 { $0 }, [ $1 + 0 ];", "=r,l"(ptr addrspace(1) %40) #3, !dbg !19
  %42 = trunc nuw nsw i64 %indvars.iv to i32, !dbg !20
  %43 = mul i32 %7, %42, !dbg !20
  %44 = sext i32 %43 to i64, !dbg !21
  %45 = getelementptr float, ptr addrspace(1) %22, i64 %44, !dbg !21
  %46 = getelementptr float, ptr addrspace(1) %23, i64 %44, !dbg !21
  %47 = getelementptr float, ptr addrspace(1) %24, i64 %44, !dbg !21
  %48 = getelementptr float, ptr addrspace(1) %25, i64 %44, !dbg !21
  %49 = getelementptr float, ptr addrspace(1) %26, i64 %44, !dbg !21
  %50 = getelementptr float, ptr addrspace(1) %27, i64 %44, !dbg !21
  %51 = getelementptr float, ptr addrspace(1) %28, i64 %44, !dbg !21
  %52 = getelementptr float, ptr addrspace(1) %29, i64 %44, !dbg !21
  %53 = getelementptr float, ptr addrspace(1) %30, i64 %44, !dbg !21
  %54 = getelementptr float, ptr addrspace(1) %31, i64 %44, !dbg !21
  %55 = getelementptr float, ptr addrspace(1) %32, i64 %44, !dbg !21
  %56 = getelementptr float, ptr addrspace(1) %33, i64 %44, !dbg !21
  %57 = getelementptr float, ptr addrspace(1) %34, i64 %44, !dbg !21
  %58 = getelementptr float, ptr addrspace(1) %35, i64 %44, !dbg !21
  %59 = getelementptr float, ptr addrspace(1) %36, i64 %44, !dbg !21
  %60 = getelementptr float, ptr addrspace(1) %37, i64 %44, !dbg !21
  %61 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %45) #3, !dbg !22
  %62 = extractvalue { i32, i32, i32, i32 } %61, 0, !dbg !22
  %63 = extractvalue { i32, i32, i32, i32 } %61, 1, !dbg !22
  %64 = extractvalue { i32, i32, i32, i32 } %61, 2, !dbg !22
  %65 = extractvalue { i32, i32, i32, i32 } %61, 3, !dbg !22
  %66 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %46) #3, !dbg !22
  %67 = extractvalue { i32, i32, i32, i32 } %66, 0, !dbg !22
  %68 = extractvalue { i32, i32, i32, i32 } %66, 1, !dbg !22
  %69 = extractvalue { i32, i32, i32, i32 } %66, 2, !dbg !22
  %70 = extractvalue { i32, i32, i32, i32 } %66, 3, !dbg !22
  %71 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %47) #3, !dbg !22
  %72 = extractvalue { i32, i32, i32, i32 } %71, 0, !dbg !22
  %73 = extractvalue { i32, i32, i32, i32 } %71, 1, !dbg !22
  %74 = extractvalue { i32, i32, i32, i32 } %71, 2, !dbg !22
  %75 = extractvalue { i32, i32, i32, i32 } %71, 3, !dbg !22
  %76 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %48) #3, !dbg !22
  %77 = extractvalue { i32, i32, i32, i32 } %76, 0, !dbg !22
  %78 = extractvalue { i32, i32, i32, i32 } %76, 1, !dbg !22
  %79 = extractvalue { i32, i32, i32, i32 } %76, 2, !dbg !22
  %80 = extractvalue { i32, i32, i32, i32 } %76, 3, !dbg !22
  %81 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %49) #3, !dbg !22
  %82 = extractvalue { i32, i32, i32, i32 } %81, 0, !dbg !22
  %83 = extractvalue { i32, i32, i32, i32 } %81, 1, !dbg !22
  %84 = extractvalue { i32, i32, i32, i32 } %81, 2, !dbg !22
  %85 = extractvalue { i32, i32, i32, i32 } %81, 3, !dbg !22
  %86 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %50) #3, !dbg !22
  %87 = extractvalue { i32, i32, i32, i32 } %86, 0, !dbg !22
  %88 = extractvalue { i32, i32, i32, i32 } %86, 1, !dbg !22
  %89 = extractvalue { i32, i32, i32, i32 } %86, 2, !dbg !22
  %90 = extractvalue { i32, i32, i32, i32 } %86, 3, !dbg !22
  %91 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %51) #3, !dbg !22
  %92 = extractvalue { i32, i32, i32, i32 } %91, 0, !dbg !22
  %93 = extractvalue { i32, i32, i32, i32 } %91, 1, !dbg !22
  %94 = extractvalue { i32, i32, i32, i32 } %91, 2, !dbg !22
  %95 = extractvalue { i32, i32, i32, i32 } %91, 3, !dbg !22
  %96 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %52) #3, !dbg !22
  %97 = extractvalue { i32, i32, i32, i32 } %96, 0, !dbg !22
  %98 = extractvalue { i32, i32, i32, i32 } %96, 1, !dbg !22
  %99 = extractvalue { i32, i32, i32, i32 } %96, 2, !dbg !22
  %100 = extractvalue { i32, i32, i32, i32 } %96, 3, !dbg !22
  %101 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %53) #3, !dbg !22
  %102 = extractvalue { i32, i32, i32, i32 } %101, 0, !dbg !22
  %103 = extractvalue { i32, i32, i32, i32 } %101, 1, !dbg !22
  %104 = extractvalue { i32, i32, i32, i32 } %101, 2, !dbg !22
  %105 = extractvalue { i32, i32, i32, i32 } %101, 3, !dbg !22
  %106 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %54) #3, !dbg !22
  %107 = extractvalue { i32, i32, i32, i32 } %106, 0, !dbg !22
  %108 = extractvalue { i32, i32, i32, i32 } %106, 1, !dbg !22
  %109 = extractvalue { i32, i32, i32, i32 } %106, 2, !dbg !22
  %110 = extractvalue { i32, i32, i32, i32 } %106, 3, !dbg !22
  %111 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %55) #3, !dbg !22
  %112 = extractvalue { i32, i32, i32, i32 } %111, 0, !dbg !22
  %113 = extractvalue { i32, i32, i32, i32 } %111, 1, !dbg !22
  %114 = extractvalue { i32, i32, i32, i32 } %111, 2, !dbg !22
  %115 = extractvalue { i32, i32, i32, i32 } %111, 3, !dbg !22
  %116 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %56) #3, !dbg !22
  %117 = extractvalue { i32, i32, i32, i32 } %116, 0, !dbg !22
  %118 = extractvalue { i32, i32, i32, i32 } %116, 1, !dbg !22
  %119 = extractvalue { i32, i32, i32, i32 } %116, 2, !dbg !22
  %120 = extractvalue { i32, i32, i32, i32 } %116, 3, !dbg !22
  %121 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %57) #3, !dbg !22
  %122 = extractvalue { i32, i32, i32, i32 } %121, 0, !dbg !22
  %123 = extractvalue { i32, i32, i32, i32 } %121, 1, !dbg !22
  %124 = extractvalue { i32, i32, i32, i32 } %121, 2, !dbg !22
  %125 = extractvalue { i32, i32, i32, i32 } %121, 3, !dbg !22
  %126 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %58) #3, !dbg !22
  %127 = extractvalue { i32, i32, i32, i32 } %126, 0, !dbg !22
  %128 = extractvalue { i32, i32, i32, i32 } %126, 1, !dbg !22
  %129 = extractvalue { i32, i32, i32, i32 } %126, 2, !dbg !22
  %130 = extractvalue { i32, i32, i32, i32 } %126, 3, !dbg !22
  %131 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %59) #3, !dbg !22
  %132 = extractvalue { i32, i32, i32, i32 } %131, 0, !dbg !22
  %133 = extractvalue { i32, i32, i32, i32 } %131, 1, !dbg !22
  %134 = extractvalue { i32, i32, i32, i32 } %131, 2, !dbg !22
  %135 = extractvalue { i32, i32, i32, i32 } %131, 3, !dbg !22
  %136 = tail call { i32, i32, i32, i32 } asm sideeffect "mov.u32 $0, 0x0;\0A\09mov.u32 $1, 0x0;\0A\09mov.u32 $2, 0x0;\0A\09mov.u32 $3, 0x0;\0A\09ld.global.v4.b32 { $0, $1, $2, $3 }, [ $4 + 0 ];", "=r,=r,=r,=r,l"(ptr addrspace(1) %60) #3, !dbg !22
  %137 = extractvalue { i32, i32, i32, i32 } %136, 0, !dbg !22
  %138 = extractvalue { i32, i32, i32, i32 } %136, 1, !dbg !22
  %139 = extractvalue { i32, i32, i32, i32 } %136, 2, !dbg !22
  %140 = extractvalue { i32, i32, i32, i32 } %136, 3, !dbg !22
  %141 = insertelement <64 x i32> poison, i32 %62, i64 0, !dbg !22
  %142 = insertelement <64 x i32> %141, i32 %63, i64 1, !dbg !22
  %143 = insertelement <64 x i32> %142, i32 %64, i64 2, !dbg !22
  %144 = insertelement <64 x i32> %143, i32 %65, i64 3, !dbg !22
  %145 = insertelement <64 x i32> %144, i32 %102, i64 4, !dbg !22
  %146 = insertelement <64 x i32> %145, i32 %103, i64 5, !dbg !22
  %147 = insertelement <64 x i32> %146, i32 %104, i64 6, !dbg !22
  %148 = insertelement <64 x i32> %147, i32 %105, i64 7, !dbg !22
  %149 = insertelement <64 x i32> %148, i32 %67, i64 8, !dbg !22
  %150 = insertelement <64 x i32> %149, i32 %68, i64 9, !dbg !22
  %151 = insertelement <64 x i32> %150, i32 %69, i64 10, !dbg !22
  %152 = insertelement <64 x i32> %151, i32 %70, i64 11, !dbg !22
  %153 = insertelement <64 x i32> %152, i32 %107, i64 12, !dbg !22
  %154 = insertelement <64 x i32> %153, i32 %108, i64 13, !dbg !22
  %155 = insertelement <64 x i32> %154, i32 %109, i64 14, !dbg !22
  %156 = insertelement <64 x i32> %155, i32 %110, i64 15, !dbg !22
  %157 = insertelement <64 x i32> %156, i32 %72, i64 16, !dbg !22
  %158 = insertelement <64 x i32> %157, i32 %73, i64 17, !dbg !22
  %159 = insertelement <64 x i32> %158, i32 %74, i64 18, !dbg !22
  %160 = insertelement <64 x i32> %159, i32 %75, i64 19, !dbg !22
  %161 = insertelement <64 x i32> %160, i32 %112, i64 20, !dbg !22
  %162 = insertelement <64 x i32> %161, i32 %113, i64 21, !dbg !22
  %163 = insertelement <64 x i32> %162, i32 %114, i64 22, !dbg !22
  %164 = insertelement <64 x i32> %163, i32 %115, i64 23, !dbg !22
  %165 = insertelement <64 x i32> %164, i32 %77, i64 24, !dbg !22
  %166 = insertelement <64 x i32> %165, i32 %78, i64 25, !dbg !22
  %167 = insertelement <64 x i32> %166, i32 %79, i64 26, !dbg !22
  %168 = insertelement <64 x i32> %167, i32 %80, i64 27, !dbg !22
  %169 = insertelement <64 x i32> %168, i32 %117, i64 28, !dbg !22
  %170 = insertelement <64 x i32> %169, i32 %118, i64 29, !dbg !22
  %171 = insertelement <64 x i32> %170, i32 %119, i64 30, !dbg !22
  %172 = insertelement <64 x i32> %171, i32 %120, i64 31, !dbg !22
  %173 = insertelement <64 x i32> %172, i32 %82, i64 32, !dbg !22
  %174 = insertelement <64 x i32> %173, i32 %83, i64 33, !dbg !22
  %175 = insertelement <64 x i32> %174, i32 %84, i64 34, !dbg !22
  %176 = insertelement <64 x i32> %175, i32 %85, i64 35, !dbg !22
  %177 = insertelement <64 x i32> %176, i32 %122, i64 36, !dbg !22
  %178 = insertelement <64 x i32> %177, i32 %123, i64 37, !dbg !22
  %179 = insertelement <64 x i32> %178, i32 %124, i64 38, !dbg !22
  %180 = insertelement <64 x i32> %179, i32 %125, i64 39, !dbg !22
  %181 = insertelement <64 x i32> %180, i32 %87, i64 40, !dbg !22
  %182 = insertelement <64 x i32> %181, i32 %88, i64 41, !dbg !22
  %183 = insertelement <64 x i32> %182, i32 %89, i64 42, !dbg !22
  %184 = insertelement <64 x i32> %183, i32 %90, i64 43, !dbg !22
  %185 = insertelement <64 x i32> %184, i32 %127, i64 44, !dbg !22
  %186 = insertelement <64 x i32> %185, i32 %128, i64 45, !dbg !22
  %187 = insertelement <64 x i32> %186, i32 %129, i64 46, !dbg !22
  %188 = insertelement <64 x i32> %187, i32 %130, i64 47, !dbg !22
  %189 = insertelement <64 x i32> %188, i32 %92, i64 48, !dbg !22
  %190 = insertelement <64 x i32> %189, i32 %93, i64 49, !dbg !22
  %191 = insertelement <64 x i32> %190, i32 %94, i64 50, !dbg !22
  %192 = insertelement <64 x i32> %191, i32 %95, i64 51, !dbg !22
  %193 = insertelement <64 x i32> %192, i32 %132, i64 52, !dbg !22
  %194 = insertelement <64 x i32> %193, i32 %133, i64 53, !dbg !22
  %195 = insertelement <64 x i32> %194, i32 %134, i64 54, !dbg !22
  %196 = insertelement <64 x i32> %195, i32 %135, i64 55, !dbg !22
  %197 = insertelement <64 x i32> %196, i32 %97, i64 56, !dbg !22
  %198 = insertelement <64 x i32> %197, i32 %98, i64 57, !dbg !22
  %199 = insertelement <64 x i32> %198, i32 %99, i64 58, !dbg !22
  %200 = insertelement <64 x i32> %199, i32 %100, i64 59, !dbg !22
  %201 = insertelement <64 x i32> %200, i32 %137, i64 60, !dbg !22
  %202 = insertelement <64 x i32> %201, i32 %138, i64 61, !dbg !22
  %203 = insertelement <64 x i32> %202, i32 %139, i64 62, !dbg !22
  %204 = insertelement <64 x i32> %203, i32 %140, i64 63, !dbg !22
  %205 = bitcast <64 x i32> %204 to <64 x float>, !dbg !22
  %206 = insertelement <64 x i32> poison, i32 %41, i64 0, !dbg !23
  %207 = bitcast <64 x i32> %206 to <64 x float>, !dbg !23
  %208 = shufflevector <64 x float> %207, <64 x float> poison, <64 x i32> zeroinitializer, !dbg !23
  %209 = fmul <64 x float> %208, %205, !dbg !23
  %210 = fadd <64 x float> %39, %209, !dbg !24
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !17
  %exitcond.not = icmp eq i64 %indvars.iv.next, %wide.trip.count, !dbg !17
  br i1 %exitcond.not, label %._crit_edge, label %.lr.ph, !dbg !17

._crit_edge:                                      ; preds = %.lr.ph, %10
  %211 = phi <64 x float> [ zeroinitializer, %10 ], [ %210, %.lr.ph ]
  %212 = shl nuw nsw i32 %14, 2, !dbg !25
  %213 = and i32 %212, 60, !dbg !25
  %214 = or disjoint i32 %213, %17, !dbg !26
  %215 = and i32 %14, 112, !dbg !11
  %216 = lshr exact i32 %215, 4, !dbg !11
  %217 = or disjoint i32 %13, %216, !dbg !12
  %218 = or disjoint i32 %217, 120, !dbg !12
  %219 = or disjoint i32 %217, 112, !dbg !12
  %220 = or disjoint i32 %217, 104, !dbg !12
  %221 = or disjoint i32 %217, 96, !dbg !12
  %222 = or disjoint i32 %217, 88, !dbg !12
  %223 = or disjoint i32 %217, 80, !dbg !12
  %224 = or disjoint i32 %217, 72, !dbg !12
  %225 = or disjoint i32 %217, 64, !dbg !12
  %226 = or disjoint i32 %217, 56, !dbg !12
  %227 = or disjoint i32 %217, 48, !dbg !12
  %228 = or disjoint i32 %217, 40, !dbg !12
  %229 = or disjoint i32 %217, 32, !dbg !12
  %230 = or disjoint i32 %217, 24, !dbg !12
  %231 = or disjoint i32 %217, 16, !dbg !12
  %232 = or disjoint i32 %217, 8, !dbg !12
  %233 = mul i32 %8, %217, !dbg !27
  %234 = mul i32 %8, %232, !dbg !27
  %235 = mul i32 %8, %231, !dbg !27
  %236 = mul i32 %8, %230, !dbg !27
  %237 = mul i32 %8, %229, !dbg !27
  %238 = mul i32 %8, %228, !dbg !27
  %239 = mul i32 %8, %227, !dbg !27
  %240 = mul i32 %8, %226, !dbg !27
  %241 = mul i32 %8, %225, !dbg !27
  %242 = mul i32 %8, %224, !dbg !27
  %243 = mul i32 %8, %223, !dbg !27
  %244 = mul i32 %8, %222, !dbg !27
  %245 = mul i32 %8, %221, !dbg !27
  %246 = mul i32 %8, %220, !dbg !27
  %247 = mul i32 %8, %219, !dbg !27
  %248 = mul i32 %8, %218, !dbg !27
  %249 = sext i32 %233 to i64, !dbg !28
  %250 = getelementptr float, ptr addrspace(1) %2, i64 %249, !dbg !28
  %251 = sext i32 %234 to i64, !dbg !28
  %252 = getelementptr float, ptr addrspace(1) %2, i64 %251, !dbg !28
  %253 = sext i32 %235 to i64, !dbg !28
  %254 = getelementptr float, ptr addrspace(1) %2, i64 %253, !dbg !28
  %255 = sext i32 %236 to i64, !dbg !28
  %256 = getelementptr float, ptr addrspace(1) %2, i64 %255, !dbg !28
  %257 = sext i32 %237 to i64, !dbg !28
  %258 = getelementptr float, ptr addrspace(1) %2, i64 %257, !dbg !28
  %259 = sext i32 %238 to i64, !dbg !28
  %260 = getelementptr float, ptr addrspace(1) %2, i64 %259, !dbg !28
  %261 = sext i32 %239 to i64, !dbg !28
  %262 = getelementptr float, ptr addrspace(1) %2, i64 %261, !dbg !28
  %263 = sext i32 %240 to i64, !dbg !28
  %264 = getelementptr float, ptr addrspace(1) %2, i64 %263, !dbg !28
  %265 = sext i32 %241 to i64, !dbg !28
  %266 = getelementptr float, ptr addrspace(1) %2, i64 %265, !dbg !28
  %267 = sext i32 %242 to i64, !dbg !28
  %268 = getelementptr float, ptr addrspace(1) %2, i64 %267, !dbg !28
  %269 = sext i32 %243 to i64, !dbg !28
  %270 = getelementptr float, ptr addrspace(1) %2, i64 %269, !dbg !28
  %271 = sext i32 %244 to i64, !dbg !28
  %272 = getelementptr float, ptr addrspace(1) %2, i64 %271, !dbg !28
  %273 = sext i32 %245 to i64, !dbg !28
  %274 = getelementptr float, ptr addrspace(1) %2, i64 %273, !dbg !28
  %275 = sext i32 %246 to i64, !dbg !28
  %276 = getelementptr float, ptr addrspace(1) %2, i64 %275, !dbg !28
  %277 = sext i32 %247 to i64, !dbg !28
  %278 = getelementptr float, ptr addrspace(1) %2, i64 %277, !dbg !28
  %279 = sext i32 %248 to i64, !dbg !28
  %280 = getelementptr float, ptr addrspace(1) %2, i64 %279, !dbg !28
  %281 = sext i32 %214 to i64, !dbg !29
  %282 = getelementptr float, ptr addrspace(1) %250, i64 %281, !dbg !29
  %283 = getelementptr float, ptr addrspace(1) %252, i64 %281, !dbg !29
  %284 = getelementptr float, ptr addrspace(1) %254, i64 %281, !dbg !29
  %285 = getelementptr float, ptr addrspace(1) %256, i64 %281, !dbg !29
  %286 = getelementptr float, ptr addrspace(1) %258, i64 %281, !dbg !29
  %287 = getelementptr float, ptr addrspace(1) %260, i64 %281, !dbg !29
  %288 = getelementptr float, ptr addrspace(1) %262, i64 %281, !dbg !29
  %289 = getelementptr float, ptr addrspace(1) %264, i64 %281, !dbg !29
  %290 = getelementptr float, ptr addrspace(1) %266, i64 %281, !dbg !29
  %291 = getelementptr float, ptr addrspace(1) %268, i64 %281, !dbg !29
  %292 = getelementptr float, ptr addrspace(1) %270, i64 %281, !dbg !29
  %293 = getelementptr float, ptr addrspace(1) %272, i64 %281, !dbg !29
  %294 = getelementptr float, ptr addrspace(1) %274, i64 %281, !dbg !29
  %295 = getelementptr float, ptr addrspace(1) %276, i64 %281, !dbg !29
  %296 = getelementptr float, ptr addrspace(1) %278, i64 %281, !dbg !29
  %297 = getelementptr float, ptr addrspace(1) %280, i64 %281, !dbg !29
  %298 = icmp slt i32 %217, %3, !dbg !30
  %299 = icmp slt i32 %232, %3, !dbg !30
  %300 = icmp slt i32 %231, %3, !dbg !30
  %301 = icmp slt i32 %230, %3, !dbg !30
  %302 = icmp slt i32 %229, %3, !dbg !30
  %303 = icmp slt i32 %228, %3, !dbg !30
  %304 = icmp slt i32 %227, %3, !dbg !30
  %305 = icmp slt i32 %226, %3, !dbg !30
  %306 = icmp slt i32 %225, %3, !dbg !30
  %307 = icmp slt i32 %224, %3, !dbg !30
  %308 = icmp slt i32 %223, %3, !dbg !30
  %309 = icmp slt i32 %222, %3, !dbg !30
  %310 = icmp slt i32 %221, %3, !dbg !30
  %311 = icmp slt i32 %220, %3, !dbg !30
  %312 = icmp slt i32 %219, %3, !dbg !30
  %313 = icmp slt i32 %218, %3, !dbg !30
  %314 = icmp slt i32 %214, %5, !dbg !31
  %315 = and i1 %298, %314, !dbg !32
  %316 = and i1 %299, %314, !dbg !32
  %317 = and i1 %300, %314, !dbg !32
  %318 = and i1 %301, %314, !dbg !32
  %319 = and i1 %302, %314, !dbg !32
  %320 = and i1 %303, %314, !dbg !32
  %321 = and i1 %304, %314, !dbg !32
  %322 = and i1 %305, %314, !dbg !32
  %323 = and i1 %306, %314, !dbg !32
  %324 = and i1 %307, %314, !dbg !32
  %325 = and i1 %308, %314, !dbg !32
  %326 = and i1 %309, %314, !dbg !32
  %327 = and i1 %310, %314, !dbg !32
  %328 = and i1 %311, %314, !dbg !32
  %329 = and i1 %312, %314, !dbg !32
  %330 = and i1 %313, %314, !dbg !32
  %331 = and i32 %14, 7, !dbg !33
  %332 = shl nuw nsw i32 %331, 12, !dbg !33
  %333 = shl nuw nsw i32 %15, 4, !dbg !33
  %334 = or disjoint i32 %332, %333, !dbg !33
  %335 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %334, !dbg !33
  %336 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 0, i32 1, i32 2, i32 3>, !dbg !33
  store <4 x float> %336, ptr addrspace(3) %335, align 16, !dbg !33
  %337 = getelementptr inbounds nuw i8, ptr addrspace(3) %335, i32 2048, !dbg !33
  %338 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 4, i32 5, i32 6, i32 7>, !dbg !33
  store <4 x float> %338, ptr addrspace(3) %337, align 16, !dbg !33
  %339 = xor i32 %334, 16, !dbg !33
  %340 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %339, !dbg !33
  %341 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 8, i32 9, i32 10, i32 11>, !dbg !33
  store <4 x float> %341, ptr addrspace(3) %340, align 16, !dbg !33
  %342 = getelementptr inbounds nuw i8, ptr addrspace(3) %340, i32 2048, !dbg !33
  %343 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 12, i32 13, i32 14, i32 15>, !dbg !33
  store <4 x float> %343, ptr addrspace(3) %342, align 16, !dbg !33
  %344 = xor i32 %334, 32, !dbg !33
  %345 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %344, !dbg !33
  %346 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 16, i32 17, i32 18, i32 19>, !dbg !33
  store <4 x float> %346, ptr addrspace(3) %345, align 16, !dbg !33
  %347 = getelementptr inbounds nuw i8, ptr addrspace(3) %345, i32 2048, !dbg !33
  %348 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 20, i32 21, i32 22, i32 23>, !dbg !33
  store <4 x float> %348, ptr addrspace(3) %347, align 16, !dbg !33
  %349 = xor i32 %334, 48, !dbg !33
  %350 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %349, !dbg !33
  %351 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 24, i32 25, i32 26, i32 27>, !dbg !33
  store <4 x float> %351, ptr addrspace(3) %350, align 16, !dbg !33
  %352 = getelementptr inbounds nuw i8, ptr addrspace(3) %350, i32 2048, !dbg !33
  %353 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 28, i32 29, i32 30, i32 31>, !dbg !33
  store <4 x float> %353, ptr addrspace(3) %352, align 16, !dbg !33
  %354 = xor i32 %334, 64, !dbg !33
  %355 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %354, !dbg !33
  %356 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 32, i32 33, i32 34, i32 35>, !dbg !33
  store <4 x float> %356, ptr addrspace(3) %355, align 16, !dbg !33
  %357 = getelementptr inbounds nuw i8, ptr addrspace(3) %355, i32 2048, !dbg !33
  %358 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 36, i32 37, i32 38, i32 39>, !dbg !33
  store <4 x float> %358, ptr addrspace(3) %357, align 16, !dbg !33
  %359 = xor i32 %334, 80, !dbg !33
  %360 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %359, !dbg !33
  %361 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 40, i32 41, i32 42, i32 43>, !dbg !33
  store <4 x float> %361, ptr addrspace(3) %360, align 16, !dbg !33
  %362 = getelementptr inbounds nuw i8, ptr addrspace(3) %360, i32 2048, !dbg !33
  %363 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 44, i32 45, i32 46, i32 47>, !dbg !33
  store <4 x float> %363, ptr addrspace(3) %362, align 16, !dbg !33
  %364 = xor i32 %334, 96, !dbg !33
  %365 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %364, !dbg !33
  %366 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 48, i32 49, i32 50, i32 51>, !dbg !33
  store <4 x float> %366, ptr addrspace(3) %365, align 16, !dbg !33
  %367 = getelementptr inbounds nuw i8, ptr addrspace(3) %365, i32 2048, !dbg !33
  %368 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 52, i32 53, i32 54, i32 55>, !dbg !33
  store <4 x float> %368, ptr addrspace(3) %367, align 16, !dbg !33
  %369 = xor i32 %334, 112, !dbg !33
  %370 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %369, !dbg !33
  %371 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 56, i32 57, i32 58, i32 59>, !dbg !33
  store <4 x float> %371, ptr addrspace(3) %370, align 16, !dbg !33
  %372 = getelementptr inbounds nuw i8, ptr addrspace(3) %370, i32 2048, !dbg !33
  %373 = shufflevector <64 x float> %211, <64 x float> poison, <4 x i32> <i32 60, i32 61, i32 62, i32 63>, !dbg !33
  store <4 x float> %373, ptr addrspace(3) %372, align 16, !dbg !33
  tail call void @llvm.nvvm.barrier.cta.sync.aligned.all(i32 0), !dbg !33
  %374 = shl nuw nsw i32 %14, 8, !dbg !33
  %375 = and i32 %374, 30720, !dbg !33
  %376 = shl nuw nsw i32 %331, 4, !dbg !33
  %377 = or disjoint i32 %375, %376, !dbg !33
  %378 = xor i32 %377, %215, !dbg !33
  %379 = getelementptr inbounds nuw i8, ptr addrspace(3) @global_smem, i32 %378, !dbg !33
  %380 = load <4 x i32>, ptr addrspace(3) %379, align 16, !dbg !33
  %381 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 128, !dbg !33
  %382 = load <4 x i32>, ptr addrspace(3) %381, align 16, !dbg !33
  %383 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 256, !dbg !33
  %384 = load <4 x i32>, ptr addrspace(3) %383, align 16, !dbg !33
  %385 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 384, !dbg !33
  %386 = load <4 x i32>, ptr addrspace(3) %385, align 16, !dbg !33
  %387 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 512, !dbg !33
  %388 = load <4 x i32>, ptr addrspace(3) %387, align 16, !dbg !33
  %389 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 640, !dbg !33
  %390 = load <4 x i32>, ptr addrspace(3) %389, align 16, !dbg !33
  %391 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 768, !dbg !33
  %392 = load <4 x i32>, ptr addrspace(3) %391, align 16, !dbg !33
  %393 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 896, !dbg !33
  %394 = load <4 x i32>, ptr addrspace(3) %393, align 16, !dbg !33
  %395 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 1024, !dbg !33
  %396 = load <4 x i32>, ptr addrspace(3) %395, align 16, !dbg !33
  %397 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 1152, !dbg !33
  %398 = load <4 x i32>, ptr addrspace(3) %397, align 16, !dbg !33
  %399 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 1280, !dbg !33
  %400 = load <4 x i32>, ptr addrspace(3) %399, align 16, !dbg !33
  %401 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 1408, !dbg !33
  %402 = load <4 x i32>, ptr addrspace(3) %401, align 16, !dbg !33
  %403 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 1536, !dbg !33
  %404 = load <4 x i32>, ptr addrspace(3) %403, align 16, !dbg !33
  %405 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 1664, !dbg !33
  %406 = load <4 x i32>, ptr addrspace(3) %405, align 16, !dbg !33
  %407 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 1792, !dbg !33
  %408 = load <4 x i32>, ptr addrspace(3) %407, align 16, !dbg !33
  %409 = getelementptr inbounds nuw i8, ptr addrspace(3) %379, i32 1920, !dbg !33
  %410 = load <4 x i32>, ptr addrspace(3) %409, align 16, !dbg !33
  %.extract = extractelement <4 x i32> %380, i64 0, !dbg !33
  %.extract64 = extractelement <4 x i32> %380, i64 1, !dbg !33
  %.extract65 = extractelement <4 x i32> %380, i64 2, !dbg !33
  %.extract66 = extractelement <4 x i32> %380, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract, i32 %.extract64, i32 %.extract65, i32 %.extract66, ptr addrspace(1) %282, i1 %315) #3, !dbg !33
  %.extract67 = extractelement <4 x i32> %382, i64 0, !dbg !33
  %.extract68 = extractelement <4 x i32> %382, i64 1, !dbg !33
  %.extract69 = extractelement <4 x i32> %382, i64 2, !dbg !33
  %.extract70 = extractelement <4 x i32> %382, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract67, i32 %.extract68, i32 %.extract69, i32 %.extract70, ptr addrspace(1) %283, i1 %316) #3, !dbg !33
  %.extract71 = extractelement <4 x i32> %384, i64 0, !dbg !33
  %.extract72 = extractelement <4 x i32> %384, i64 1, !dbg !33
  %.extract73 = extractelement <4 x i32> %384, i64 2, !dbg !33
  %.extract74 = extractelement <4 x i32> %384, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract71, i32 %.extract72, i32 %.extract73, i32 %.extract74, ptr addrspace(1) %284, i1 %317) #3, !dbg !33
  %.extract75 = extractelement <4 x i32> %386, i64 0, !dbg !33
  %.extract76 = extractelement <4 x i32> %386, i64 1, !dbg !33
  %.extract77 = extractelement <4 x i32> %386, i64 2, !dbg !33
  %.extract78 = extractelement <4 x i32> %386, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract75, i32 %.extract76, i32 %.extract77, i32 %.extract78, ptr addrspace(1) %285, i1 %318) #3, !dbg !33
  %.extract79 = extractelement <4 x i32> %388, i64 0, !dbg !33
  %.extract80 = extractelement <4 x i32> %388, i64 1, !dbg !33
  %.extract81 = extractelement <4 x i32> %388, i64 2, !dbg !33
  %.extract82 = extractelement <4 x i32> %388, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract79, i32 %.extract80, i32 %.extract81, i32 %.extract82, ptr addrspace(1) %286, i1 %319) #3, !dbg !33
  %.extract83 = extractelement <4 x i32> %390, i64 0, !dbg !33
  %.extract84 = extractelement <4 x i32> %390, i64 1, !dbg !33
  %.extract85 = extractelement <4 x i32> %390, i64 2, !dbg !33
  %.extract86 = extractelement <4 x i32> %390, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract83, i32 %.extract84, i32 %.extract85, i32 %.extract86, ptr addrspace(1) %287, i1 %320) #3, !dbg !33
  %.extract87 = extractelement <4 x i32> %392, i64 0, !dbg !33
  %.extract88 = extractelement <4 x i32> %392, i64 1, !dbg !33
  %.extract89 = extractelement <4 x i32> %392, i64 2, !dbg !33
  %.extract90 = extractelement <4 x i32> %392, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract87, i32 %.extract88, i32 %.extract89, i32 %.extract90, ptr addrspace(1) %288, i1 %321) #3, !dbg !33
  %.extract91 = extractelement <4 x i32> %394, i64 0, !dbg !33
  %.extract92 = extractelement <4 x i32> %394, i64 1, !dbg !33
  %.extract93 = extractelement <4 x i32> %394, i64 2, !dbg !33
  %.extract94 = extractelement <4 x i32> %394, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract91, i32 %.extract92, i32 %.extract93, i32 %.extract94, ptr addrspace(1) %289, i1 %322) #3, !dbg !33
  %.extract95 = extractelement <4 x i32> %396, i64 0, !dbg !33
  %.extract96 = extractelement <4 x i32> %396, i64 1, !dbg !33
  %.extract97 = extractelement <4 x i32> %396, i64 2, !dbg !33
  %.extract98 = extractelement <4 x i32> %396, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract95, i32 %.extract96, i32 %.extract97, i32 %.extract98, ptr addrspace(1) %290, i1 %323) #3, !dbg !33
  %.extract99 = extractelement <4 x i32> %398, i64 0, !dbg !33
  %.extract100 = extractelement <4 x i32> %398, i64 1, !dbg !33
  %.extract101 = extractelement <4 x i32> %398, i64 2, !dbg !33
  %.extract102 = extractelement <4 x i32> %398, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract99, i32 %.extract100, i32 %.extract101, i32 %.extract102, ptr addrspace(1) %291, i1 %324) #3, !dbg !33
  %.extract103 = extractelement <4 x i32> %400, i64 0, !dbg !33
  %.extract104 = extractelement <4 x i32> %400, i64 1, !dbg !33
  %.extract105 = extractelement <4 x i32> %400, i64 2, !dbg !33
  %.extract106 = extractelement <4 x i32> %400, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract103, i32 %.extract104, i32 %.extract105, i32 %.extract106, ptr addrspace(1) %292, i1 %325) #3, !dbg !33
  %.extract107 = extractelement <4 x i32> %402, i64 0, !dbg !33
  %.extract108 = extractelement <4 x i32> %402, i64 1, !dbg !33
  %.extract109 = extractelement <4 x i32> %402, i64 2, !dbg !33
  %.extract110 = extractelement <4 x i32> %402, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract107, i32 %.extract108, i32 %.extract109, i32 %.extract110, ptr addrspace(1) %293, i1 %326) #3, !dbg !33
  %.extract111 = extractelement <4 x i32> %404, i64 0, !dbg !33
  %.extract112 = extractelement <4 x i32> %404, i64 1, !dbg !33
  %.extract113 = extractelement <4 x i32> %404, i64 2, !dbg !33
  %.extract114 = extractelement <4 x i32> %404, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract111, i32 %.extract112, i32 %.extract113, i32 %.extract114, ptr addrspace(1) %294, i1 %327) #3, !dbg !33
  %.extract115 = extractelement <4 x i32> %406, i64 0, !dbg !33
  %.extract116 = extractelement <4 x i32> %406, i64 1, !dbg !33
  %.extract117 = extractelement <4 x i32> %406, i64 2, !dbg !33
  %.extract118 = extractelement <4 x i32> %406, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract115, i32 %.extract116, i32 %.extract117, i32 %.extract118, ptr addrspace(1) %295, i1 %328) #3, !dbg !33
  %.extract119 = extractelement <4 x i32> %408, i64 0, !dbg !33
  %.extract120 = extractelement <4 x i32> %408, i64 1, !dbg !33
  %.extract121 = extractelement <4 x i32> %408, i64 2, !dbg !33
  %.extract122 = extractelement <4 x i32> %408, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract119, i32 %.extract120, i32 %.extract121, i32 %.extract122, ptr addrspace(1) %296, i1 %329) #3, !dbg !33
  %.extract123 = extractelement <4 x i32> %410, i64 0, !dbg !33
  %.extract124 = extractelement <4 x i32> %410, i64 1, !dbg !33
  %.extract125 = extractelement <4 x i32> %410, i64 2, !dbg !33
  %.extract126 = extractelement <4 x i32> %410, i64 3, !dbg !33
  tail call void asm sideeffect "@$5 st.global.v4.b32 [ $4 + 0 ], { $0, $1, $2, $3 };", "r,r,r,r,l,b"(i32 %.extract123, i32 %.extract124, i32 %.extract125, i32 %.extract126, ptr addrspace(1) %297, i1 %330) #3, !dbg !33
  ret void, !dbg !34
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef range(i32 0, 2147483647) i32 @llvm.nvvm.read.ptx.sreg.ctaid.x() #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef range(i32 0, 65535) i32 @llvm.nvvm.read.ptx.sreg.ctaid.y() #1

; Function Attrs: mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare noundef range(i32 0, 1024) i32 @llvm.nvvm.read.ptx.sreg.tid.x() #1

; Function Attrs: convergent nocallback nounwind
declare void @llvm.nvvm.barrier.cta.sync.aligned.all(i32) #2

attributes #0 = { "nvvm.reqntid"="128" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { convergent nocallback nounwind }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3}
!llvm.ident = !{!4}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "triton", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly)
!1 = !DIFile(filename: "matmul.py", directory: "/home/ubuntu/triton")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 4, !"nvvm-reflect-ftz", i32 1}
!4 = !{!"clang version 3.8.0 (tags/RELEASE_380/final)"}
!5 = distinct !DISubprogram(name: "matrix_multiplication_kernel", linkageName: "matrix_multiplication_kernel", scope: !1, file: !1, line: 6, type: !6, scopeLine: 6, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!6 = !DISubroutineType(cc: DW_CC_normal, types: !7)
!7 = !{}
!8 = !DILocation(line: 17, column: 26, scope: !5)
!9 = !DILocation(line: 18, column: 26, scope: !5)
!10 = !DILocation(line: 20, column: 21, scope: !5)
!11 = !DILocation(line: 20, column: 49, scope: !5)
!12 = !DILocation(line: 20, column: 36, scope: !5)
!13 = !DILocation(line: 21, column: 21, scope: !5)
!14 = !DILocation(line: 24, column: 39, scope: !5)
!15 = !DILocation(line: 24, column: 21, scope: !5)
!16 = !DILocation(line: 25, column: 21, scope: !5)
!17 = !DILocation(line: 30, column: 19, scope: !5)
!18 = !DILocation(line: 32, column: 29, scope: !5)
!19 = !DILocation(line: 32, column: 20, scope: !5)
!20 = !DILocation(line: 33, column: 33, scope: !5)
!21 = !DILocation(line: 33, column: 29, scope: !5)
!22 = !DILocation(line: 33, column: 20, scope: !5)
!23 = !DILocation(line: 34, column: 27, scope: !5)
!24 = !DILocation(line: 34, column: 23, scope: !5)
!25 = !DILocation(line: 21, column: 49, scope: !5)
!26 = !DILocation(line: 21, column: 36, scope: !5)
!27 = !DILocation(line: 37, column: 39, scope: !5)
!28 = !DILocation(line: 37, column: 21, scope: !5)
!29 = !DILocation(line: 37, column: 51, scope: !5)
!30 = !DILocation(line: 40, column: 33, scope: !5)
!31 = !DILocation(line: 40, column: 58, scope: !5)
!32 = !DILocation(line: 40, column: 39, scope: !5)
!33 = !DILocation(line: 41, column: 21, scope: !5)
!34 = !DILocation(line: 41, column: 4, scope: !5)
