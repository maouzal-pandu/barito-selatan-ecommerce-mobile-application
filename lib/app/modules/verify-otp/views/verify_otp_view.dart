import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/verify_otp_controller.dart';
import 'package:pinput/pinput.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  const VerifyOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // biarkan true supaya scaffold menyesuaikan saat keyboard muncul
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          // Background Gradient
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFFD54F), Color(0xFFFFA726)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 24),

                      // Icon Decoration
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.verified_rounded,
                          size: 45,
                          color: Colors.amber[700],
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Verifikasi OTP",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "Masukkan kode OTP yang dikirimkan ke email kamu.",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 24),

                      // Bagian putih bawah yang mengisi sisa layar dan scrollable saat keyboard muncul
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              // beri padding bottom setara keyboard supaya konten tidak tertutup
                              padding: EdgeInsets.only(
                                bottom: MediaQuery.of(
                                  context,
                                ).viewInsets.bottom,
                              ),
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: ConstrainedBox(
                                // pastikan child minimal setinggi space yang tersedia
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight,
                                ),
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(28),
                                      topRight: Radius.circular(28),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 20),

                                        // --- Pinput ---
                                        Pinput(
                                          length: 6,
                                          controller: controller.otpController,
                                          defaultPinTheme: PinTheme(
                                            width: 55,
                                            height: 60,
                                            textStyle: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF5F5F5),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Color(0xFFE0E0E0),
                                              ),
                                            ),
                                          ),
                                          focusedPinTheme: PinTheme(
                                            width: 55,
                                            height: 60,
                                            textStyle: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.amber,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          onCompleted: (value) {
                                            controller.verifyOTP();
                                          },
                                        ),

                                        const SizedBox(height: 40),

                                        // Button Verify
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                controller.verifyOTP(),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.amber[700],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(14),
                                              ),
                                            ),
                                            child: const Text(
                                              "Verifikasi",
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 20),

                                        // Resend OTP
                                        TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Kirim ulang kode OTP",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        // beri spacer di bawah supaya tombol tidak mepet dengan ujung
                                        const SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
