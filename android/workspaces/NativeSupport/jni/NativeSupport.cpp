#include <string.h>
#include <jni.h>
#include <android/log.h>
#include <stdio.h>

#define FFMPEG_LOG_LEVEL AV_LOG_WARNING
#define LOG_LEVEL 2
#define LOG_TAG "NativeSupport"
#define LOGI(...)  __android_log_print(ANDROID_LOG_INFO, LOG_TAG, __VA_ARGS__)
#define LOGE(...)  __android_log_print(ANDROID_LOG_ERROR, LOG_TAG, __VA_ARGS__)
#define LOGV(...)  __android_log_print(ANDROID_LOG_VERBOSE, LOG_TAG, __VA_ARGS__)


JavaVM* myGlobalJavaVM;
int a = 0;

extern "C" {
JNIEXPORT jstring JNICALL Java_com_example_nativesupport_MainActivity_invokeNativeFunction(
		JNIEnv * env, jobject obj);
JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *pvt);
JNIEXPORT void JNICALL JNI_OnUnload(JavaVM *vm, void *pvt);
}

JNIEXPORT jstring JNICALL Java_com_example_nativesupport_MainActivity_invokeNativeFunction(
		JNIEnv * env, jobject obj) {
	//return env->NewStringUTF("Hello From CPP");
	//char outCStr[128] = "Hello From CPP";
	char outCStr[128];
	snprintf(outCStr, 128, "Hello From CPP %d", a);
	return env->NewStringUTF(outCStr);
}

//jint JNI_OnLoad(JavaVM* pVM, void* reserved) {
//	myGlobalJavaVM = pVM;
//	JNIEnv *lEnv;
//	if (pVM->GetEnv((void**) &lEnv, JNI_VERSION_1_6) != JNI_OK) {
//// A problem occured
//		return -1;
//	}
////	LOGE("JNI_OnLoad\n");
////	__android_log_print(ANDROID_LOG_INFO, LOG_TAG, "JNI_OnLoad\n")
//	fprintf( stdout, "* JNI_OnLoad called\n" );
//	return JNI_VERSION_1_6;
//}

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM *vm, void *pvt) {
	//fprintf(stdout, "* JNI_OnLoad called\n");
//	LOGI("JNI_OnLoad");
	a++;
	return JNI_VERSION_1_6;
}

JNIEXPORT void JNICALL JNI_OnUnload(JavaVM *vm, void *pvt) {
	a++;
	fprintf(stdout, "* JNI_OnUnload called\n");
}
